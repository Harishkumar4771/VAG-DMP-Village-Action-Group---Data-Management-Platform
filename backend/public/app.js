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
  // Auth Elements
  const loginOverlay = document.getElementById('login-overlay');
  const mainAppContent = document.getElementById('main-app-content');
  const loginStep1 = document.getElementById('login-step-1');
  const loginStep2 = document.getElementById('login-step-2');
  const btnRequestOtp = document.getElementById('btn-request-otp');
  const btnVerifyOtp = document.getElementById('btn-verify-otp');
  const btnBackPhone = document.getElementById('btn-back-phone');
  const loginPhone = document.getElementById('login-phone');
  const loginOtp = document.getElementById('login-otp');
  const btnLogout = document.getElementById('btn-logout');
  let authPhone = '';
  const syncToggleBtn = document.getElementById('sync-toggle-btn');
  const syncStatusText = document.getElementById('sync-status-text');
  const syncDot = document.getElementById('sync-dot');
  const syncWidgetTitle = document.getElementById('sync-widget-title');
  const syncWidgetDesc = document.getElementById('sync-widget-desc');
  const pendingQueueBadge = document.getElementById('pending-queue-badge');
  const btnManualSync = document.getElementById('btn-manual-sync');

  // Modal Elements
  const modalCreateIssue = document.getElementById('modal-create-issue');
  const modalProgressUpdate = document.getElementById('modal-progress-update');
  const modalCreateMeeting = document.getElementById('modal-create-meeting');
  const modalAdminReview = document.getElementById('modal-admin-review');
  const formCreateIssue = document.getElementById('form-create-issue');
  const formProgressUpdate = document.getElementById('form-progress-update');
  const formCreateMeeting = document.getElementById('form-create-meeting');
  const issueVillageSelect = document.getElementById('issue-village');
  const meetingVillageSelect = document.getElementById('meeting-village');

  // Trigger buttons
  const btnCreateIssue = document.getElementById('btn-create-issue');
  const btnCreateIssueAlt = document.getElementById('btn-create-issue-alt');
  const btnCreateMeetingMain = document.getElementById('btn-create-meeting-main');
  const btnNewMeeting = document.getElementById('btn-new-meeting');

  // File Upload State
  let currentInitialPhotoData = null;
  let currentProgressPhotoData = null;

  document.getElementById('issue-photo-input').addEventListener('change', (e) => {
    handleFileUpload(e, 'initial-photo-preview', (data) => currentInitialPhotoData = data);
  });

  document.getElementById('progress-photo-input').addEventListener('change', (e) => {
    handleFileUpload(e, 'progress-photo-preview', (data) => currentProgressPhotoData = data);
  });

  function handleFileUpload(e, previewId, callback) {
    const file = e.target.files[0];
    if (!file) return;
    const reader = new FileReader();
    reader.onload = (event) => {
      const dataUrl = event.target.result;
      callback(dataUrl);
      const previewDiv = document.getElementById(previewId);
      previewDiv.innerHTML = `<img src="${dataUrl}" class="photo-thumbnail" alt="Uploaded Photo">`;
      e.target.closest('.file-upload-area').classList.add('has-file');
    };
    reader.readAsDataURL(file);
  }

  // Progress update period selection logic
  document.querySelectorAll('.period-option').forEach(option => {
    option.addEventListener('click', function() {
      document.querySelectorAll('.period-option').forEach(opt => opt.classList.remove('selected'));
      this.classList.add('selected');
      this.querySelector('input').checked = true;
    });
  });

  // --- API CALLS ---
  async function apiFetch(url, options = {}) {
    const token = localStorage.getItem('token');
    const headers = {
      'Content-Type': 'application/json',
      ...(token ? { 'Authorization': `Bearer ${token}` } : {}),
      ...(options.headers || {}),
    };
    const res = await fetch(url, { ...options, headers });
    if (res.status === 401) {
      handleLogout();
    }
    return res;
  }

  async function fetchVillages() {
    try {
      const res = await apiFetch('/v1/villages');
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
      const res = await apiFetch('/v1/issues');
      if (!res.ok) throw new Error('Failed to fetch issues');
      const data = await res.json();
      state.issues = data.items || [];
      renderIssues();
      renderRecentIssues();
      renderVerificationList();
      updateDashboardStats();
      fetchReminders();
    } catch (e) {
      console.error('Error fetching issues:', e);
    }
  }

  async function fetchMeetings() {
    try {
      const res = await apiFetch('/v1/meetings');
      if (!res.ok) throw new Error('Failed to fetch meetings');
      state.meetings = await res.json();
      renderMeetings();
      renderDashboardMeetings();
      updateDashboardStats();
    } catch (e) {
      console.error('Error fetching meetings:', e);
    }
  }

  async function fetchReminders() {
    try {
      const res = await apiFetch('/v1/progress/reminders');
      if (!res.ok) throw new Error('Failed to fetch reminders');
      const reminders = await res.json();
      renderFollowUpReminders(reminders);
      
      const awaitingUpdate = reminders.filter(r => r.status === 'overdue' || r.status === 'due_soon').length;
      document.getElementById('stat-awaiting-update').textContent = awaitingUpdate;
    } catch (e) {
      console.error('Error fetching reminders:', e);
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

  window.switchView = function(viewName) {
    navLinks.forEach((l) => l.classList.remove('active'));
    viewSections.forEach((s) => s.classList.remove('active'));

    const activeLink = document.querySelector(`.nav-link[data-view="${viewName === 'issue-detail' ? 'issues' : viewName}"]`);
    const activeSection = document.getElementById(`view-${viewName}`);

    if (activeLink) activeLink.classList.add('active');
    if (activeSection) activeSection.classList.add('active');
  }

  // --- AUTH LOGIC ---
  async function checkAuth() {
    const token = localStorage.getItem('token');
    if (!token) {
      showLogin();
      return;
    }
    try {
      const res = await apiFetch('/v1/auth/me');
      if (res.ok) {
        const user = await res.json();
        state.currentRole = user.role;
        const adminNav = document.getElementById('admin-nav-link');
        if (adminNav) {
          adminNav.style.display = state.currentRole === 'ADMIN' ? 'flex' : 'none';
        }
        showApp();
      } else {
        handleLogout();
      }
    } catch (e) {
      showLogin();
    }
  }

  function showLogin() {
    loginOverlay.style.display = 'flex';
    mainAppContent.style.display = 'none';
    loginStep1.style.display = 'block';
    loginStep2.style.display = 'none';
  }

  function showApp() {
    loginOverlay.style.display = 'none';
    mainAppContent.style.display = 'block';
    initData();
  }

  function handleLogout() {
    localStorage.removeItem('token');
    state.villages = [];
    state.issues = [];
    state.meetings = [];
    showLogin();
  }

  if (btnLogout) btnLogout.addEventListener('click', handleLogout);


  if (btnVerifyOtp) {
    btnVerifyOtp.addEventListener('click', async () => {
      const phone = loginPhone.value.trim();
      if (phone.length < 10) return showToast('Enter valid 10-digit phone');
      const otp = loginOtp.value.trim();
      if (otp.length !== 6) return showToast('Enter 6-digit OTP');
      
      btnVerifyOtp.textContent = 'Verifying...';
      try {
        const res = await fetch('/v1/auth/verify-otp', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({ phone, otp })
        });
        if (res.ok) {
          const data = await res.json();
          localStorage.setItem('token', data.token);
          showToast('Login successful!');
          checkAuth();
        } else {
          const err = await res.json();
          showToast(err.message || 'Invalid OTP');
        }
      } catch (e) {
        showToast('Network error');
      } finally {
        btnVerifyOtp.textContent = 'Verify & Login';
      }
    });
  }


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
      const issuePayloads = state.pendingSyncQueue.filter((i) => i.type === 'issue').map((i) => i.data);
      const meetingPayloads = state.pendingSyncQueue.filter((i) => i.type === 'meeting').map((i) => i.data);
      const progressPayloads = state.pendingSyncQueue.filter((i) => i.type === 'progress');

      if (issuePayloads.length > 0 || meetingPayloads.length > 0) {
        const payload = { issues: issuePayloads, meetings: meetingPayloads };
        const res = await apiFetch('/v1/sync/push', {
          method: 'POST',
          body: JSON.stringify(payload),
        });
        if (!res.ok) throw new Error('Sync failed');
      }

      // Sync progress updates one by one (could be optimized with a batch endpoint later)
      for (const pu of progressPayloads) {
        await apiFetch(`/v1/issues/${pu.issueId}/progress`, {
          method: 'POST',
          body: JSON.stringify(pu.data)
        });
      }

      state.pendingSyncQueue = [];
      updateQueueUI();
      showToast('✅ Cloud Sync complete! Pending items successfully uploaded.');
      fetchIssues();
      fetchMeetings();
    } catch (e) {
      showToast('Failed to sync queue with server.');
    }
  }

  function updateQueueUI() {
    pendingQueueBadge.textContent = state.pendingSyncQueue.length;
  }

  // --- RENDERING FUNCTIONS ---
  function updateDashboardStats() {
    const reported = state.issues.filter(i => i.status === 'reported').length;
    const inProgress = state.issues.filter(i => i.status === 'in_progress' || i.status === 'in_progress').length;
    const completed = state.issues.filter(i => i.status === 'resolved').length;

    document.getElementById('stat-reported').textContent = reported;
    document.getElementById('stat-in-progress').textContent = inProgress;
    document.getElementById('stat-completed').textContent = completed;
    document.getElementById('stat-villages').textContent = state.villages.length;
    document.getElementById('stat-meetings').textContent = state.meetings.length;

    // Category counts
    const countWater = state.issues.filter((i) => i.category === 'water').length;
    const countRoad = state.issues.filter((i) => i.category === 'road').length;
    const countEdu = state.issues.filter((i) => i.category === 'education').length;
    const countSoc = state.issues.filter((i) => i.category === 'society').length;

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

  function renderFollowUpReminders(reminders) {
    const listEl = document.getElementById('reminders-list');
    if (!listEl) return;

    if (reminders.length === 0) {
      listEl.innerHTML = `<div style="padding: 1rem; text-align: center; color: var(--text-muted); font-size: 0.85rem;">No follow-up updates pending.</div>`;
      return;
    }

    listEl.innerHTML = reminders.map(r => `
      <div class="reminder-item" onclick="openIssueDetail('${r.issueId}')">
        <div style="flex: 1;">
          <div class="reminder-item-text">${escapeHtml(r.issueTitle)}</div>
          <div class="reminder-item-sub">${escapeHtml(r.villageName)} • ${getCategoryLabel(r.category)}</div>
        </div>
        <span class="reminder-badge ${r.status}">
          ${r.type === '15_DAY' ? '15-Day' : '1-Month'} ${r.status === 'overdue' ? 'Overdue' : (r.status === 'due_soon' ? 'Due Soon' : 'Upcoming')}
        </span>
      </div>
    `).join('');
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
        const vName = issue.village?.name || 'Unknown Village';
        const statusBadge = getStatusBadge(issue.status);
        
        let progressNodes = '<div class="issue-card-timeline">';
        progressNodes += `<div class="timeline-mini-dot filled"></div>`;
        const has15d = issue.history?.some(p => p.type === '15_DAY');
        const has1m = issue.history?.some(p => p.type === '1_MONTH');
        progressNodes += `<div class="timeline-mini-line ${has15d ? 'filled' : ''}"></div>`;
        progressNodes += `<div class="timeline-mini-dot ${has15d ? 'filled' : ''}"></div>`;
        progressNodes += `<div class="timeline-mini-line ${has1m ? 'filled' : ''}"></div>`;
        progressNodes += `<div class="timeline-mini-dot ${has1m ? 'filled' : ''}"></div>`;
        progressNodes += '</div>';

        return `
          <tr>
            <td>
              <strong>${escapeHtml(issue.title)}</strong><br>
              <span class="subtext">${getCategoryLabel(issue.category)}</span>
            </td>
            <td>${escapeHtml(vName)}</td>
            <td>${statusBadge}</td>
            <td>${progressNodes}</td>
            <td>
              <button class="btn btn-sm btn-outline" onclick="openIssueDetail('${issue.id}')">View</button>
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
          i.description.toLowerCase().includes(q) ||
          (i.village && i.village.name.toLowerCase().includes(q))
      );
    }

    if (filtered.length === 0) {
      gridEl.innerHTML = `<div style="grid-column: 1/-1; text-align: center; padding: 2rem; color: var(--text-muted);">No matching ground issues found.</div>`;
      return;
    }

    gridEl.innerHTML = filtered
      .map((issue) => {
        const vName = issue.village?.name || 'Unknown Village';
        const statusBadge = getStatusBadge(issue.status);
        
        let progressNodes = '<div class="issue-card-timeline" style="margin-top: 0.75rem;">';
        progressNodes += `<div class="timeline-mini-dot filled"></div>`;
        const has15d = issue.history?.some(p => p.type === '15_DAY');
        const has1m = issue.history?.some(p => p.type === '1_MONTH');
        progressNodes += `<div class="timeline-mini-line ${has15d ? 'filled' : ''}"></div>`;
        progressNodes += `<div class="timeline-mini-dot ${has15d ? 'filled' : ''}"></div>`;
        progressNodes += `<div class="timeline-mini-line ${has1m ? 'filled' : ''}"></div>`;
        progressNodes += `<div class="timeline-mini-dot ${has1m ? 'filled' : ''}"></div>`;
        progressNodes += '</div>';

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
              <p style="font-size: 0.85rem; color: var(--text-muted); margin-top: 0.5rem; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden;">
                ${escapeHtml(issue.description)}
              </p>
              ${progressNodes}
            </div>
            <div style="display: flex; justify-content: flex-end; margin-top: 1rem;">
              <button class="btn btn-sm btn-outline" onclick="openIssueDetail('${issue.id}')">Details & Timeline</button>
            </div>
          </div>
        `;
      })
      .join('');
  }

  window.openIssueDetail = function(issueId) {
    const issue = state.issues.find(i => i.id === issueId);
    if (!issue) return;

    const contentDiv = document.getElementById('issue-detail-content');
    
    // Prepare timeline data
    const created_at = new Date(issue.created_at);
    
    let timelineHtml = `
      <div class="timeline-node completed">
        <div class="timeline-node-title">Reported</div>
        <div class="timeline-node-date">${created_at.toLocaleDateString()}</div>
        <div class="timeline-node-desc">${escapeHtml(issue.description)}</div>
      </div>
      
      <div class="timeline-node completed">
        <div class="timeline-node-title">Initial Action Taken</div>
        <div class="timeline-node-date">${created_at.toLocaleDateString()}</div>
        <div class="timeline-node-desc">${escapeHtml(issue.action_taken)}</div>
        ${issue.attachments && issue.attachments.find(m => m.type === 'INITIAL' || m.type === 'BEFORE') ? 
          `<div class="timeline-node-photo">
             <img src="${issue.attachments.find(m => m.type === 'INITIAL' || m.type === 'BEFORE').url}" alt="Initial Photo">
           </div>` : ''}
      </div>
    `;

    const update15d = issue.history?.find(p => p.type === '15_DAY');
    if (update15d) {
      timelineHtml += `
        <div class="timeline-node completed">
          <div class="timeline-node-title">15-Day Progress Update <span class="badge" style="background:var(--background); border:1px solid var(--surface-border); margin-left:8px;">${update15d.status.replace(/_/g, ' ')}</span></div>
          <div class="timeline-node-date">${new Date(update15d.scheduled_date).toLocaleDateString()}</div>
          <div class="timeline-node-desc">${escapeHtml(update15d.description)}</div>
          ${update15d.photoUrl ? `<div class="timeline-node-photo"><img src="${update15d.photoUrl}" alt="Progress Photo"></div>` : ''}
        </div>
      `;
    } else {
      const due15d = new Date(created_at);
      due15d.setDate(due15d.getDate() + 15);
      const isOverdue = new Date() > due15d;
      
      timelineHtml += `
        <div class="timeline-node ${isOverdue ? 'overdue' : 'pending'}">
          <div class="timeline-node-title">15-Day Progress Update</div>
          <div class="timeline-node-date">Due: ${due15d.toLocaleDateString()} ${isOverdue ? '<span style="color:red;font-weight:bold;">(Overdue)</span>' : ''}</div>
          <button class="timeline-add-btn" onclick="openProgressUpdateModal('${issue.id}', '15_DAY')">+ Add Progress Update</button>
        </div>
      `;
    }

    const update1m = issue.history?.find(p => p.type === '1_MONTH');
    if (update1m) {
      timelineHtml += `
        <div class="timeline-node completed">
          <div class="timeline-node-title">1-Month Progress Update <span class="badge" style="background:var(--background); border:1px solid var(--surface-border); margin-left:8px;">${update1m.status.replace(/_/g, ' ')}</span></div>
          <div class="timeline-node-date">${new Date(update1m.scheduled_date).toLocaleDateString()}</div>
          <div class="timeline-node-desc">${escapeHtml(update1m.description)}</div>
          ${update1m.photoUrl ? `<div class="timeline-node-photo"><img src="${update1m.photoUrl}" alt="Progress Photo"></div>` : ''}
        </div>
      `;
    } else {
      const due1m = new Date(created_at);
      due1m.setMonth(due1m.getMonth() + 1);
      const isOverdue = new Date() > due1m;
      
      timelineHtml += `
        <div class="timeline-node ${isOverdue ? 'overdue' : 'pending'}">
          <div class="timeline-node-title">1-Month Progress Update</div>
          <div class="timeline-node-date">Due: ${due1m.toLocaleDateString()} ${isOverdue ? '<span style="color:red;font-weight:bold;">(Overdue)</span>' : ''}</div>
          <button class="timeline-add-btn" onclick="openProgressUpdateModal('${issue.id}', '1_MONTH')">+ Add Progress Update</button>
        </div>
      `;
    }

    contentDiv.innerHTML = `
      <div class="section-header">
        <button class="back-btn" onclick="switchView('issues')">
          <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><line x1="19" y1="12" x2="5" y2="12"></line><polyline points="12 19 5 12 12 5"></polyline></svg>
          Back to Issues
        </button>
      </div>

      <div class="issue-detail-header">
        <div class="detail-title">
          <h2>${escapeHtml(issue.title)}</h2>
          <div class="issue-detail-meta">
            <span>📍 ${escapeHtml(issue.village?.name || 'Unknown')}</span>
            <span>🏷️ ${getCategoryLabel(issue.category)}</span>
            <span>📅 Reported: ${created_at.toLocaleDateString()}</span>
          </div>
        </div>
        ${getStatusBadge(issue.status)}
      </div>

      <div class="issue-detail-body">
        <div class="detail-main">
          <div class="detail-info-block">
            <div class="detail-section-title">Progress Timeline</div>
            <div class="progress-timeline" style="margin-top: 1rem;">
              ${timelineHtml}
            </div>
          </div>
        </div>
        <div class="detail-side">
          <div class="detail-info-block">
            <div class="detail-section-title">Expenditure Summary</div>
            <div style="font-size: 0.85rem; margin-bottom: 0.75rem;">
              <strong>Initial Estimate:</strong><br>
              ${escapeHtml(issue.expenditure || 'None provided')}
            </div>
            ${issue.history?.map(p => p.expenditure ? `
              <div style="font-size: 0.85rem; margin-bottom: 0.75rem;">
                <strong>${p.type === '15_DAY' ? '15-Day' : '1-Month'} Upscheduled_date:</strong><br>
                ${escapeHtml(p.expenditure)}
              </div>
            ` : '').join('') || ''}
          </div>
        </div>
      </div>
    `;

    switchView('issue-detail');
  };

  window.openProgressUpdateModal = function(issueId, type) {
    document.getElementById('progress-issue-id').value = issueId;
    
    // Select the correct radio button
    document.querySelectorAll('.period-option').forEach(opt => opt.classList.remove('selected'));
    if (type === '15_DAY') {
      const opt = document.getElementById('period-15day');
      opt.classList.add('selected');
      opt.querySelector('input').checked = true;
    } else {
      const opt = document.getElementById('period-1month');
      opt.classList.add('selected');
      opt.querySelector('input').checked = true;
    }
    
    // Reset form
    document.getElementById('progress-status').value = 'NOT_STARTED';
    document.getElementById('progress-description').value = '';
    document.getElementById('progress-expenditure').value = '';
    document.getElementById('progress-notes').value = '';
    document.getElementById('progress-photo-preview').innerHTML = '';
    currentProgressPhotoData = null;
    document.getElementById('progress-photo-upload').classList.remove('has-file');

    modalProgressUpdate.classList.add('active');
  };

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
        const dateStr = new Date(mtg.scheduled_date).toLocaleDateString('en-IN', {
          weekday: 'short',
          month: 'short',
          day: 'numeric',
          hour: '2-digit',
          minute: '2-digit',
        });
        const vName = mtg.village?.name || 'Unknown';

        return `
          <div class="meeting-card">
            <div class="meeting-date-badge">📅 ${dateStr}</div>
            <h4 style="font-size: 1rem; font-weight: 700;">Gram Sabha Meeting - ${escapeHtml(vName)}</h4>
            <div style="font-size: 0.82rem; color: var(--text-muted); margin-top: 0.4rem;">
              👥 Attendees: <strong>${mtg?.attendees?.length || 0} members</strong>
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
      const vName = mtg.village?.name || 'Unknown';
      return `
        <div style="padding: 0.6rem 0; border-bottom: 1px solid var(--surface-border);">
          <strong style="font-size: 0.85rem;">Gram Sabha - ${escapeHtml(vName)}</strong>
          <div style="font-size: 0.78rem; color: var(--text-muted);">👥 ${mtg?.attendees?.length || 0} Members | Status: ${mtg.status}</div>
        </div>
      `;
    }).join('');
  }

  function renderVerificationList() {
    const listEl = document.getElementById('verification-list');
    if (!listEl) return;

    const pending = state.issues.filter((i) => i.status === 'reported' || i.status === 'escalated');

    if (pending.length === 0) {
      listEl.innerHTML = `<div style="text-align: center; padding: 3rem; background: var(--surface); border-radius: var(--radius-lg); border: 1px solid var(--surface-border);">
        <p style="font-size: 1.1rem; font-weight: 700; color: var(--primary);">🎉 All Submissions Verified!</p>
        <p style="font-size: 0.85rem; color: var(--text-muted);">No submissions currently pending admin verification.</p>
      </div>`;
      return;
    }

    listEl.innerHTML = pending
      .map((issue) => {
        const vName = issue.village?.name || 'Unknown';
        const proofs = issue.attachments || [];
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
            <p style="font-size: 0.88rem; margin-top: 0.75rem;"><strong>Problem:</strong> ${escapeHtml(issue.description)}</p>
            <p style="font-size: 0.88rem; margin-top: 0.25rem;"><strong>Action Taken:</strong> ${escapeHtml(issue.action_taken)}</p>
            ${proofs.length > 0 ? `<div class="proof-photos-preview" style="margin-top: 0.75rem;">${proofs.map((p) => `<img src="${p.url}" class="proof-img">`).join('')}</div>` : ''}
          </div>
        `;
      })
      .join('');
  }

  // --- HELPER FUNCTIONS ---
  function getStatusBadge(status) {
    const s = (status || 'reported').toLowerCase();
    const formattedStatus = (status || 'reported').replace(/_/g, ' ');
    return `<span class="status-pill status-${s}">${formattedStatus}</span>`;
  }

  function getCategoryLabel(cat) {
    switch (cat) {
      case 'water': return '💧 Water';
      case 'road': return '🛣️ Road';
      case 'education': return '🎓 Education';
      case 'society': return '👥 Society';
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
    const proofs = issue.attachments || [];
    const timeline = issue.history || [];

    detailsContainer.innerHTML = `
      <h4 style="font-size: 1.1rem; font-weight: 800;">${escapeHtml(issue.title)}</h4>
      <p style="font-size: 0.85rem; color: var(--text-muted);">Village: ${escapeHtml(issue.village?.name || 'Unknown')} | Status: <strong>${issue.status}</strong></p>
      <div style="margin-top: 0.75rem; background: var(--background); padding: 0.85rem; border-radius: var(--radius-md);">
        <p style="font-size: 0.88rem;"><strong>Problem Description:</strong> ${escapeHtml(issue.description)}</p>
        <p style="font-size: 0.88rem; margin-top: 0.4rem;"><strong>Resolution Action:</strong> ${escapeHtml(issue.action_taken)}</p>
        ${issue.expenditure ? `<p style="font-size: 0.85rem; color: var(--primary); font-weight: 700; margin-top: 0.4rem;">Expenditure: ${escapeHtml(issue.expenditure)}</p>` : ''}
      </div>
      ${proofs.length > 0 ? `<div style="margin-top: 0.75rem;"><strong>Uploaded Physical Proofs:</strong><div class="proof-photos-preview" style="margin-top: 0.4rem;">${proofs.map((p) => `<img src="${p.url}" class="proof-img">`).join('')}</div></div>` : ''}
      ${timeline.length > 0 ? `<div style="margin-top: 0.85rem; font-size: 0.82rem;"><strong>Activity Timeline:</strong><ul style="padding-left: 1.2rem; margin-top: 0.25rem;">${timeline.map((t) => `<li>${t.note} (${new Date(t.scheduled_date).toLocaleDateString()})</li>`).join('')}</ul></div>` : ''}
    `;

    modalAdminReview.classList.add('active');
  };

  document.querySelectorAll('.modal-close').forEach((btn) => {
    btn.addEventListener('click', () => {
      modalCreateIssue.classList.remove('active');
      modalProgressUpdate.classList.remove('active');
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
    const village_id = document.getElementById('issue-village').value;
    const description = document.getElementById('issue-desc').value;
    const action_taken = document.getElementById('issue-action').value;
    const expenditure = document.getElementById('issue-expenditure').value;
    const location = document.getElementById('issue-location').value;
    const notes = document.getElementById('issue-notes').value;

    if (!currentInitialPhotoData) {
      showToast('⚠️ Please upload an initial photo as proof.');
      return;
    }

    const issuePayload = {
      title,
      category,
      village_id,
      description,
      action_taken,
      expenditure,
      beforePhotoUrls: [currentInitialPhotoData], // Passed to backend mapping
      status: 'reported',
      leader_idId: 'leader-001',
    };

    if (notes) {
      issuePayload.description += `\n\nNotes: ${notes}`;
    }
    if (location) {
      issuePayload.description += `\nLocation: ${location}`;
    }

    if (!state.isOnline) {
      // Store in offline queue
      state.pendingSyncQueue.push({ type: 'issue', data: issuePayload });
      updateQueueUI();
      modalCreateIssue.classList.remove('active');
      formCreateIssue.reset();
      currentInitialPhotoData = null;
      document.getElementById('initial-photo-preview').innerHTML = '';
      document.getElementById('initial-photo-upload').classList.remove('has-file');
      showToast('📦 Saved offline! Item queued for sync.');
      return;
    }

    try {
      const res = await apiFetch('/v1/issues', {
        method: 'POST',
        body: JSON.stringify(issuePayload),
      });

      if (res.ok) {
        showToast('✅ Issue reported successfully!');
        modalCreateIssue.classList.remove('active');
        formCreateIssue.reset();
        currentInitialPhotoData = null;
        document.getElementById('initial-photo-preview').innerHTML = '';
        document.getElementById('initial-photo-upload').classList.remove('has-file');
        fetchIssues();
      }
    } catch (e) {
      showToast('Error submitting issue.');
    }
  });

  // CREATE PROGRESS UPDATE FORM SUBMISSION
  formProgressUpdate.addEventListener('submit', async (e) => {
    e.preventDefault();
    const issueId = document.getElementById('progress-issue-id').value;
    const type = document.querySelector('input[name="progress-type"]:checked').value;
    const status = document.getElementById('progress-status').value;
    const description = document.getElementById('progress-description').value;
    const expenditure = document.getElementById('progress-expenditure').value;
    const notes = document.getElementById('progress-notes').value;

    if (!currentProgressPhotoData) {
      showToast('⚠️ Please upload a progress photo as proof.');
      return;
    }

    const payload = {
      type,
      status,
      description,
      photoDataUrl: currentProgressPhotoData,
      expenditure,
      notes,
    };

    if (!state.isOnline) {
      state.pendingSyncQueue.push({ type: 'progress', issueId, data: payload });
      updateQueueUI();
      modalProgressUpdate.classList.remove('active');
      formProgressUpdate.reset();
      currentProgressPhotoData = null;
      document.getElementById('progress-photo-preview').innerHTML = '';
      document.getElementById('progress-photo-upload').classList.remove('has-file');
      showToast('📦 Progress update saved offline!');
      
      // Update UI optimistically
      const issue = state.issues.find(i => i.id === issueId);
      if (issue) {
        if (!issue.history) issue.history = [];
        issue.history.push({ ...payload, scheduled_date: new Date().toISOString() });
        openIssueDetail(issueId);
      }
      return;
    }

    try {
      const res = await apiFetch(`/v1/issues/${issueId}/progress`, {
        method: 'POST',
        body: JSON.stringify(payload),
      });

      if (res.ok) {
        showToast('✅ Progress update submitted successfully!');
        modalProgressUpdate.classList.remove('active');
        formProgressUpdate.reset();
        currentProgressPhotoData = null;
        document.getElementById('progress-photo-preview').innerHTML = '';
        document.getElementById('progress-photo-upload').classList.remove('has-file');
        
        // Refresh issues to get updated status and timeline
        await fetchIssues();
        
        // If we are currently on the detail view, re-render it
        const currentActiveLink = document.querySelector('.nav-link.active');
        if (currentActiveLink && currentActiveLink.getAttribute('data-view') === 'issues' && document.getElementById('view-issue-detail').classList.contains('active')) {
           openIssueDetail(issueId);
        }
      } else {
        const error = await res.json();
        showToast(`Error: ${error.message || 'Failed to submit progress update'}`);
      }
    } catch (e) {
      showToast('Error submitting progress update.');
    }
  });


  // CREATE MEETING FORM SUBMISSION
  formCreateMeeting.addEventListener('submit', async (e) => {
    e.preventDefault();
    const village_id = document.getElementById('meeting-village').value;
    const date = document.getElementById('meeting-date').value;
    const attendees_count = Number(document.getElementById('meeting-attendees').value);
    const notes = document.getElementById('meeting-notes').value;

    const meetingPayload = { village_id, date, attendees_count, notes };

    try {
      const res = await apiFetch('/v1/meetings', {
        method: 'POST',
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
      const res = await apiFetch(`/v1/issues/${issueId}/status`, {
        method: 'PATCH',
        body: JSON.stringify({ status: 'resolved', adminReviewNote: note || 'Verified by Admin' }),
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
      const res = await apiFetch(`/v1/issues/${issueId}/status`, {
        method: 'PATCH',
        body: JSON.stringify({ status: 'escalated', adminReviewNote: note || 'Revision requested by Admin' }),
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
  checkAuth();
});
