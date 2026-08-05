// VAG-DMP Frontend JavaScript Application
document.addEventListener('DOMContentLoaded', () => {
  // App State
  const state = {
    currentRole: 'LEADER', // 'LEADER' or 'ADMIN'
    isOnline: true,
    pendingSyncQueue: [],
    villages: [],
    issues: [],
    meetings: [],
    selectedCategory: 'ALL',
    selectedStatus: 'ALL',
    villageFilterStatus: 'ALL',
    issuesSearchQuery: '',
    villageSearchQuery: '',
  };

  // DOM Elements
  const navLinks = document.querySelectorAll('.nav-link');
  const viewSections = document.querySelectorAll('.view-section');
  const roleSelect = document.getElementById('role-switch');
  const syncToggleBtn = document.getElementById('sync-toggle-btn');
  const syncStatusText = document.getElementById('sync-status-text');
  const syncDot = document.getElementById('sync-dot');
  const syncWidgetTitle = document.getElementById('sync-widget-title');
  const syncWidgetDesc = document.getElementById('sync-widget-desc');
  const pendingQueueBadge = document.getElementById('pending-queue-badge');
  const btnManualSync = document.getElementById('btn-manual-sync');

  // Modal Elements
  const modalCreateIssue = document.getElementById('modal-create-issue');
  const modalCreateMeeting = document.getElementById('modal-create-meeting');
  const modalAdminReview = document.getElementById('modal-admin-review');
  const formCreateIssue = document.getElementById('form-create-issue');
  const formCreateMeeting = document.getElementById('form-create-meeting');
  const issueVillageSelect = document.getElementById('issue-village');
  const meetingVillageSelect = document.getElementById('meeting-village');

  // Trigger buttons
  const btnCreateIssue = document.getElementById('btn-create-issue');
  const btnCreateIssueAlt = document.getElementById('btn-create-issue-alt');
  const btnCreateMeetingMain = document.getElementById('btn-create-meeting-main');
  const btnNewMeeting = document.getElementById('btn-new-meeting');

  // --- API CALLS ---
  async function fetchVillages() {
    try {
      const res = await fetch('/v1/villages');
      if (!res.ok) throw new Error('Failed to fetch villages');
      state.villages = await res.json();
      renderVillages();
      populateVillageSelects();
      updateDashboardStats();
    } catch (e) {
      console.error('Error fetching villages:', e);
    }
  }

  async function fetchIssues() {
    try {
      const res = await fetch('/v1/issues');
      if (!res.ok) throw new Error('Failed to fetch issues');
      const data = await res.json();
      state.issues = data.items || [];
      renderIssues();
      renderRecentIssues();
      renderVerificationList();
      updateDashboardStats();
    } catch (e) {
      console.error('Error fetching issues:', e);
    }
  }

  async function fetchMeetings() {
    try {
      const res = await fetch('/v1/meetings');
      if (!res.ok) throw new Error('Failed to fetch meetings');
      state.meetings = await res.json();
      renderMeetings();
      renderDashboardMeetings();
      updateDashboardStats();
    } catch (e) {
      console.error('Error fetching meetings:', e);
    }
  }

  function initData() {
    fetchVillages();
    fetchIssues();
    fetchMeetings();
  }

  // --- NAVIGATION ---
  navLinks.forEach((link) => {
    link.addEventListener('click', () => {
      const targetView = link.getAttribute('data-view');
      switchView(targetView);
    });
  });

  function switchView(viewName) {
    navLinks.forEach((l) => l.classList.remove('active'));
    viewSections.forEach((s) => s.classList.remove('active'));

    const activeLink = document.querySelector(`.nav-link[data-view="${viewName}"]`);
    const activeSection = document.getElementById(`view-${viewName}`);

    if (activeLink) activeLink.classList.add('active');
    if (activeSection) activeSection.classList.add('active');
  }

  // --- ROLE SWITCHING ---
  roleSelect.addEventListener('change', (e) => {
    state.currentRole = e.target.value;
    showToast(`Role switched to ${state.currentRole === 'ADMIN' ? 'Admin Verifier' : 'Village Leader'}`);
    renderVerificationList();
  });

  // --- SYNC ENGINE TOGGLE ---
  syncToggleBtn.addEventListener('click', () => {
    state.isOnline = !state.isOnline;
    if (state.isOnline) {
      syncToggleBtn.classList.remove('offline');
      syncToggleBtn.classList.add('online');
      syncStatusText.textContent = 'Online Sync Active';
      syncDot.classList.remove('offline');
      syncDot.classList.add('online');
      syncWidgetTitle.textContent = 'Engine Connected';
      syncWidgetDesc.textContent = 'Pending changes will automatically sync when online.';
      showToast('🌐 Network re-connected! Auto-syncing pending items...');
      processOfflineQueue();
    } else {
      syncToggleBtn.classList.add('offline');
      syncToggleBtn.classList.remove('online');
      syncStatusText.textContent = 'Offline Mode (Queued)';
      syncDot.classList.add('offline');
      syncDot.classList.remove('online');
      syncWidgetTitle.textContent = 'Offline Mode Active';
      syncWidgetDesc.textContent = 'Items stored locally in queue until network returns.';
      showToast('⚠️ Switched to Offline Mode. Submissions will queue locally.');
    }
  });

  btnManualSync.addEventListener('click', () => {
    processOfflineQueue();
  });

  async function processOfflineQueue() {
    if (state.pendingSyncQueue.length === 0) {
      showToast('Sync queue is clear. All data is up to date!');
      return;
    }

    try {
      const payload = {
        issues: state.pendingSyncQueue.filter((i) => i.type === 'issue').map((i) => i.data),
        meetings: state.pendingSyncQueue.filter((i) => i.type === 'meeting').map((i) => i.data),
      };

      const res = await fetch('/v1/sync', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(payload),
      });

      if (res.ok) {
        state.pendingSyncQueue = [];
        updateQueueUI();
        showToast('✅ Cloud Sync complete! Pending items successfully uploaded.');
        fetchIssues();
        fetchMeetings();
      }
    } catch (e) {
      showToast('Failed to sync queue with server.');
    }
  }

  function updateQueueUI() {
    pendingQueueBadge.textContent = state.pendingSyncQueue.length;
  }

  // --- RENDERING FUNCTIONS ---
  function updateDashboardStats() {
    document.getElementById('stat-villages').textContent = state.villages.length;
    document.getElementById('stat-active-issues').textContent = state.issues.length;
    document.getElementById('stat-verified-issues').textContent = state.issues.filter((i) => i.status === 'VERIFIED').length;
    document.getElementById('stat-meetings').textContent = state.meetings.length;

    // Category counts
    const countWater = state.issues.filter((i) => i.category === 'WATER').length;
    const countRoad = state.issues.filter((i) => i.category === 'ROAD').length;
    const countEdu = state.issues.filter((i) => i.category === 'EDUCATION').length;
    const countSoc = state.issues.filter((i) => i.category === 'SOCIETY').length;

    document.getElementById('count-water').textContent = `${countWater} Issue${countWater !== 1 ? 's' : ''}`;
    document.getElementById('count-road').textContent = `${countRoad} Issue${countRoad !== 1 ? 's' : ''}`;
    document.getElementById('count-education').textContent = `${countEdu} Issue${countEdu !== 1 ? 's' : ''}`;
    document.getElementById('count-society').textContent = `${countSoc} Issue${countSoc !== 1 ? 's' : ''}`;
  }

  function populateVillageSelects() {
    const optionsHtml = state.villages
      .map((v) => `<option value="${v.id}">${v.name} (${v.district})</option>`)
      .join('');
    if (issueVillageSelect) issueVillageSelect.innerHTML = optionsHtml;
    if (meetingVillageSelect) meetingVillageSelect.innerHTML = optionsHtml;
  }

  function renderRecentIssues() {
    const listEl = document.getElementById('recent-issues-list');
    if (!listEl) return;

    if (state.issues.length === 0) {
      listEl.innerHTML = `<tr><td colspan="5" style="text-align:center; color: var(--text-muted);">No issue records found.</td></tr>`;
      return;
    }

    const recent = state.issues.slice(0, 5);
    listEl.innerHTML = recent
      .map((issue) => {
        const vName = issue.village?.name || 'Chandpur';
        const statusBadge = getStatusBadge(issue.status);
        const proofs = issue.media || [];
        const mediaCount = proofs.length;

        return `
          <tr>
            <td>
              <strong>${escapeHtml(issue.title)}</strong><br>
              <span class="subtext">${getCategoryLabel(issue.category)}</span>
            </td>
            <td>${escapeHtml(vName)}</td>
            <td>${statusBadge}</td>
            <td>${mediaCount > 0 ? `📸 ${mediaCount} Proof photos` : '📄 Documentation'}</td>
            <td>
              <button class="btn btn-sm btn-outline" onclick="openReviewModal('${issue.id}')">View</button>
            </td>
          </tr>
        `;
      })
      .join('');
  }

  function renderIssues() {
    const gridEl = document.getElementById('issues-grid');
    if (!gridEl) return;

    let filtered = [...state.issues];

    if (state.selectedCategory !== 'ALL') {
      filtered = filtered.filter((i) => i.category === state.selectedCategory);
    }
    if (state.selectedStatus !== 'ALL') {
      filtered = filtered.filter((i) => i.status === state.selectedStatus);
    }
    if (state.issuesSearchQuery) {
      const q = state.issuesSearchQuery.toLowerCase();
      filtered = filtered.filter(
        (i) =>
          i.title.toLowerCase().includes(q) ||
          i.problemDescription.toLowerCase().includes(q) ||
          (i.village && i.village.name.toLowerCase().includes(q))
      );
    }

    if (filtered.length === 0) {
      gridEl.innerHTML = `<div style="grid-column: 1/-1; text-align: center; padding: 2rem; color: var(--text-muted);">No matching ground issues found.</div>`;
      return;
    }

    gridEl.innerHTML = filtered
      .map((issue) => {
        const vName = issue.village?.name || 'Chandpur';
        const statusBadge = getStatusBadge(issue.status);
        const photos = issue.media || [];

        return `
          <div class="issue-card">
            <div>
              <div class="issue-card-header">
                <h4>${escapeHtml(issue.title)}</h4>
                ${statusBadge}
              </div>
              <div class="issue-meta">
                <span>📍 ${escapeHtml(vName)}</span>
                <span>🏷️ ${getCategoryLabel(issue.category)}</span>
              </div>
              <p style="font-size: 0.85rem; color: var(--text-muted); margin-top: 0.5rem;">
                ${escapeHtml(issue.problemDescription)}
              </p>
              ${
                issue.expenditureDetails
                  ? `<div style="font-size: 0.8rem; font-weight: 700; color: var(--primary); margin-top: 0.4rem;">💰 Expenditure: ${escapeHtml(issue.expenditureDetails)}</div>`
                  : ''
              }
              ${
                photos.length > 0
                  ? `<div class="proof-photos-preview">
                      ${photos
                        .map((p) => `<img src="${p.url}" class="proof-img" alt="Proof" onerror="this.src='https://images.unsplash.com/photo-1541888946425-d0fbb186a5b3?auto=format&fit=crop&w=150&q=80'">`)
                        .join('')}
                    </div>`
                  : ''
              }
            </div>
            <div style="display: flex; justify-content: flex-end; margin-top: 0.75rem;">
              <button class="btn btn-sm btn-outline" onclick="openReviewModal('${issue.id}')">Details & Timeline</button>
            </div>
          </div>
        `;
      })
      .join('');
  }

  function renderVillages() {
    const gridEl = document.getElementById('villages-grid');
    if (!gridEl) return;

    let filtered = [...state.villages];
    if (state.villageFilterStatus !== 'ALL') {
      filtered = filtered.filter((v) => v.status === state.villageFilterStatus);
    }
    if (state.villageSearchQuery) {
      const q = state.villageSearchQuery.toLowerCase();
      filtered = filtered.filter((v) => v.name.toLowerCase().includes(q) || v.district.toLowerCase().includes(q));
    }

    gridEl.innerHTML = filtered
      .map((v) => {
        const needsAttention = v.status === 'Needs Attention';
        return `
          <div class="village-card">
            <div class="village-card-top">
              <div class="village-icon">📍</div>
              <div>
                <div class="village-name">${escapeHtml(v.name)}</div>
                <div class="village-district">District: ${escapeHtml(v.district)}, ${v.state || 'MH'}</div>
              </div>
            </div>
            <div style="font-size: 0.82rem; color: var(--text-muted); display: flex; justify-content: space-between; margin-top: 0.5rem;">
              <span>👥 ${v.memberCount || 0} Members</span>
              <span>🕒 ${v.lastActivity || 'Active'}</span>
            </div>
            <div style="margin-top: 0.75rem;">
              <span class="badge ${needsAttention ? 'status-revision_requested' : 'badge-accent'}">
                ${v.status || 'Active'}
              </span>
            </div>
          </div>
        `;
      })
      .join('');
  }

  function renderMeetings() {
    const gridEl = document.getElementById('meetings-grid');
    if (!gridEl) return;

    gridEl.innerHTML = state.meetings
      .map((mtg) => {
        const dateStr = new Date(mtg.date).toLocaleDateString('en-IN', {
          weekday: 'short',
          month: 'short',
          day: 'numeric',
          hour: '2-digit',
          minute: '2-digit',
        });
        const vName = mtg.village?.name || 'Chandpur';

        return `
          <div class="meeting-card">
            <div class="meeting-date-badge">📅 ${dateStr}</div>
            <h4 style="font-size: 1rem; font-weight: 700;">Gram Sabha Meeting - ${escapeHtml(vName)}</h4>
            <div style="font-size: 0.82rem; color: var(--text-muted); margin-top: 0.4rem;">
              👥 Attendees: <strong>${mtg.attendeesCount} members</strong>
            </div>
            ${mtg.notes ? `<p style="font-size: 0.84rem; margin-top: 0.5rem; color: var(--text-main);">${escapeHtml(mtg.notes)}</p>` : ''}
            <div style="margin-top: 0.75rem;">
              <span class="status-pill status-${mtg.status.toLowerCase()}">${mtg.status}</span>
            </div>
          </div>
        `;
      })
      .join('');
  }

  function renderDashboardMeetings() {
    const listEl = document.getElementById('dashboard-meetings-list');
    if (!listEl) return;

    listEl.innerHTML = state.meetings.slice(0, 3).map((mtg) => {
      const vName = mtg.village?.name || 'Chandpur';
      return `
        <div style="padding: 0.6rem 0; border-bottom: 1px solid var(--surface-border);">
          <strong style="font-size: 0.85rem;">Gram Sabha - ${escapeHtml(vName)}</strong>
          <div style="font-size: 0.78rem; color: var(--text-muted);">👥 ${mtg.attendeesCount} Members | Status: ${mtg.status}</div>
        </div>
      `;
    }).join('');
  }

  function renderVerificationList() {
    const listEl = document.getElementById('verification-list');
    if (!listEl) return;

    const pending = state.issues.filter((i) => i.status === 'SUBMITTED' || i.status === 'REVISION_REQUESTED');

    if (pending.length === 0) {
      listEl.innerHTML = `<div style="text-align: center; padding: 3rem; background: var(--surface); border-radius: var(--radius-lg); border: 1px solid var(--surface-border);">
        <p style="font-size: 1.1rem; font-weight: 700; color: var(--primary);">🎉 All Submissions Verified!</p>
        <p style="font-size: 0.85rem; color: var(--text-muted);">No submissions currently pending admin verification.</p>
      </div>`;
      return;
    }

    listEl.innerHTML = pending
      .map((issue) => {
        const vName = issue.village?.name || 'Chandpur';
        const proofs = issue.media || [];
        return `
          <div class="card-box margin-top">
            <div class="flex-between">
              <div>
                <span class="status-pill status-${issue.status.toLowerCase()}">${issue.status}</span>
                <h3 style="font-size: 1.1rem; font-weight: 800; margin-top: 0.3rem;">${escapeHtml(issue.title)}</h3>
                <span class="subtext">Village: ${escapeHtml(vName)} | Reported by Leader</span>
              </div>
              <button class="btn btn-primary btn-sm" onclick="openReviewModal('${issue.id}')">Review & Verify</button>
            </div>
            <p style="font-size: 0.88rem; margin-top: 0.75rem;"><strong>Problem:</strong> ${escapeHtml(issue.problemDescription)}</p>
            <p style="font-size: 0.88rem; margin-top: 0.25rem;"><strong>Action Taken:</strong> ${escapeHtml(issue.actionTaken)}</p>
            ${proofs.length > 0 ? `<div class="proof-photos-preview" style="margin-top: 0.75rem;">${proofs.map((p) => `<img src="${p.url}" class="proof-img">`).join('')}</div>` : ''}
          </div>
        `;
      })
      .join('');
  }

  // --- HELPER FUNCTIONS ---
  function getStatusBadge(status) {
    const s = (status || 'SUBMITTED').toLowerCase();
    return `<span class="status-pill status-${s}">${status || 'SUBMITTED'}</span>`;
  }

  function getCategoryLabel(cat) {
    switch (cat) {
      case 'WATER': return '💧 Water';
      case 'ROAD': return '🛣️ Road';
      case 'EDUCATION': return '🎓 Education';
      case 'SOCIETY': return '👥 Society';
      default: return cat;
    }
  }

  function escapeHtml(str) {
    if (!str) return '';
    return str.replace(/[&<>"']/g, (m) => {
      return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#039;' }[m];
    });
  }

  function showToast(msg) {
    const container = document.getElementById('toast-container');
    const toast = document.createElement('div');
    toast.className = 'toast';
    toast.textContent = msg;
    container.appendChild(toast);
    setTimeout(() => toast.remove(), 4000);
  }

  // --- MODAL CONTROLS & EVENT LISTENERS ---
  window.openReviewModal = function (issueId) {
    const issue = state.issues.find((i) => i.id === issueId);
    if (!issue) return;

    document.getElementById('review-issue-id').value = issue.id;
    const detailsContainer = document.getElementById('review-issue-details');
    const proofs = issue.media || [];
    const timeline = issue.timeline || [];

    detailsContainer.innerHTML = `
      <h4 style="font-size: 1.1rem; font-weight: 800;">${escapeHtml(issue.title)}</h4>
      <p style="font-size: 0.85rem; color: var(--text-muted);">Village: ${escapeHtml(issue.village?.name || 'Chandpur')} | Status: <strong>${issue.status}</strong></p>
      <div style="margin-top: 0.75rem; background: var(--background); padding: 0.85rem; border-radius: var(--radius-md);">
        <p style="font-size: 0.88rem;"><strong>Problem Description:</strong> ${escapeHtml(issue.problemDescription)}</p>
        <p style="font-size: 0.88rem; margin-top: 0.4rem;"><strong>Resolution Action:</strong> ${escapeHtml(issue.actionTaken)}</p>
        ${issue.expenditureDetails ? `<p style="font-size: 0.85rem; color: var(--primary); font-weight: 700; margin-top: 0.4rem;">Expenditure: ${escapeHtml(issue.expenditureDetails)}</p>` : ''}
      </div>
      ${proofs.length > 0 ? `<div style="margin-top: 0.75rem;"><strong>Uploaded Physical Proofs:</strong><div class="proof-photos-preview" style="margin-top: 0.4rem;">${proofs.map((p) => `<img src="${p.url}" class="proof-img">`).join('')}</div></div>` : ''}
      ${timeline.length > 0 ? `<div style="margin-top: 0.85rem; font-size: 0.82rem;"><strong>Activity Timeline:</strong><ul style="padding-left: 1.2rem; margin-top: 0.25rem;">${timeline.map((t) => `<li>${t.note} (${new Date(t.date).toLocaleDateString()})</li>`).join('')}</ul></div>` : ''}
    `;

    modalAdminReview.classList.add('active');
  };

  document.querySelectorAll('.modal-close').forEach((btn) => {
    btn.addEventListener('click', () => {
      modalCreateIssue.classList.remove('active');
      modalCreateMeeting.classList.remove('active');
      modalAdminReview.classList.remove('active');
    });
  });

  if (btnCreateIssue) btnCreateIssue.addEventListener('click', () => modalCreateIssue.classList.add('active'));
  if (btnCreateIssueAlt) btnCreateIssueAlt.addEventListener('click', () => modalCreateIssue.classList.add('active'));
  if (btnCreateMeetingMain) btnCreateMeetingMain.addEventListener('click', () => modalCreateMeeting.classList.add('active'));
  if (btnNewMeeting) btnNewMeeting.addEventListener('click', () => modalCreateMeeting.classList.add('active'));

  // CREATE ISSUE FORM SUBMISSION
  formCreateIssue.addEventListener('submit', async (e) => {
    e.preventDefault();
    const title = document.getElementById('issue-title').value;
    const category = document.getElementById('issue-category').value;
    const villageId = document.getElementById('issue-village').value;
    const problemDescription = document.getElementById('issue-desc').value;
    const actionTaken = document.getElementById('issue-action').value;
    const expenditureDetails = document.getElementById('issue-expenditure').value;
    const beforeUrl = document.getElementById('issue-before-photo').value;
    const afterUrl = document.getElementById('issue-after-photo').value;

    const issuePayload = {
      title,
      category,
      villageId,
      problemDescription,
      actionTaken,
      expenditureDetails,
      beforePhotoUrls: beforeUrl ? [beforeUrl] : [],
      afterPhotoUrls: afterUrl ? [afterUrl] : [],
      submittedById: 'leader-001',
    };

    if (!state.isOnline) {
      // Store in offline queue
      state.pendingSyncQueue.push({ type: 'issue', data: issuePayload });
      updateQueueUI();
      modalCreateIssue.classList.remove('active');
      formCreateIssue.reset();
      showToast('📦 Saved offline! Item queued for sync.');
      return;
    }

    try {
      const res = await fetch('/v1/issues', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(issuePayload),
      });

      if (res.ok) {
        showToast('✅ Issue reported & submitted to backend!');
        modalCreateIssue.classList.remove('active');
        formCreateIssue.reset();
        fetchIssues();
      }
    } catch (e) {
      showToast('Error submitting issue.');
    }
  });

  // CREATE MEETING FORM SUBMISSION
  formCreateMeeting.addEventListener('submit', async (e) => {
    e.preventDefault();
    const villageId = document.getElementById('meeting-village').value;
    const date = document.getElementById('meeting-date').value;
    const attendeesCount = Number(document.getElementById('meeting-attendees').value);
    const notes = document.getElementById('meeting-notes').value;

    const meetingPayload = { villageId, date, attendeesCount, notes };

    try {
      const res = await fetch('/v1/meetings', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(meetingPayload),
      });

      if (res.ok) {
        showToast('📅 Gram Sabha Meeting scheduled successfully!');
        modalCreateMeeting.classList.remove('active');
        formCreateMeeting.reset();
        fetchMeetings();
      }
    } catch (e) {
      showToast('Error scheduling meeting.');
    }
  });

  // ADMIN VERIFICATION ACTIONS
  document.getElementById('btn-verify-approve').addEventListener('click', async () => {
    const issueId = document.getElementById('review-issue-id').value;
    const note = document.getElementById('admin-note').value;

    try {
      const res = await fetch(`/v1/issues/${issueId}/status`, {
        method: 'PATCH',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ status: 'VERIFIED', adminReviewNote: note || 'Verified by Admin' }),
      });

      if (res.ok) {
        showToast('🌟 Issue verified and approved!');
        modalAdminReview.classList.remove('active');
        fetchIssues();
      }
    } catch (e) {
      showToast('Error updating status.');
    }
  });

  document.getElementById('btn-request-revision').addEventListener('click', async () => {
    const issueId = document.getElementById('review-issue-id').value;
    const note = document.getElementById('admin-note').value;

    try {
      const res = await fetch(`/v1/issues/${issueId}/status`, {
        method: 'PATCH',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ status: 'REVISION_REQUESTED', adminReviewNote: note || 'Revision requested by Admin' }),
      });

      if (res.ok) {
        showToast('⚠️ Revision requested from Leader.');
        modalAdminReview.classList.remove('active');
        fetchIssues();
      }
    } catch (e) {
      showToast('Error requesting revision.');
    }
  });

  // CATEGORY & SEARCH FILTERS
  document.getElementById('issue-category-filters').addEventListener('click', (e) => {
    if (e.target.classList.contains('chip')) {
      document.querySelectorAll('#issue-category-filters .chip').forEach((c) => c.classList.remove('active'));
      e.target.classList.add('active');
      state.selectedCategory = e.target.getAttribute('data-cat');
      renderIssues();
    }
  });

  document.getElementById('issue-status-filter').addEventListener('change', (e) => {
    state.selectedStatus = e.target.value;
    renderIssues();
  });

  document.getElementById('issues-search').addEventListener('input', (e) => {
    state.issuesSearchQuery = e.target.value;
    renderIssues();
  });

  document.getElementById('village-search').addEventListener('input', (e) => {
    state.villageSearchQuery = e.target.value;
    renderVillages();
  });

  document.getElementById('village-status-filters').addEventListener('click', (e) => {
    if (e.target.classList.contains('chip')) {
      document.querySelectorAll('#village-status-filters .chip').forEach((c) => c.classList.remove('active'));
      e.target.classList.add('active');
      state.villageFilterStatus = e.target.getAttribute('data-vfilter');
      renderVillages();
    }
  });

  // Initialize
  initData();
});
