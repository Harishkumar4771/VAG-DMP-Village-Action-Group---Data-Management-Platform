const fs = require('fs');
let content = fs.readFileSync('backend/public/app.js', 'utf8');

// 1. Remove roleSelect DOM element
content = content.replace("const roleSelect = document.getElementById('role-switch');", 
  "// Auth Elements\n" +
  "  const loginOverlay = document.getElementById('login-overlay');\n" +
  "  const mainAppContent = document.getElementById('main-app-content');\n" +
  "  const loginStep1 = document.getElementById('login-step-1');\n" +
  "  const loginStep2 = document.getElementById('login-step-2');\n" +
  "  const btnRequestOtp = document.getElementById('btn-request-otp');\n" +
  "  const btnVerifyOtp = document.getElementById('btn-verify-otp');\n" +
  "  const btnBackPhone = document.getElementById('btn-back-phone');\n" +
  "  const loginPhone = document.getElementById('login-phone');\n" +
  "  const loginOtp = document.getElementById('login-otp');\n" +
  "  const btnLogout = document.getElementById('btn-logout');\n" +
  "  let authPhone = '';"
);

// 2. Replace roleSelect event listener
content = content.replace(/\/\/ --- ROLE SWITCHING ---[\s\S]*?renderVerificationList\(\);\n  \}\);/m, 
  `// --- AUTH LOGIC ---
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

  if (btnRequestOtp) {
    btnRequestOtp.addEventListener('click', async () => {
      const phone = loginPhone.value.trim();
      if (phone.length < 10) return showToast('Enter valid 10-digit phone');
      
      btnRequestOtp.textContent = 'Sending...';
      try {
        const res = await fetch('/v1/auth/request-otp', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({ phone })
        });
        if (res.ok) {
          authPhone = phone;
          loginStep1.style.display = 'none';
          loginStep2.style.display = 'block';
          showToast('OTP sent (use 123456)');
        } else {
          const err = await res.json();
          showToast(err.message || 'Failed to send OTP');
        }
      } catch (e) {
        showToast('Network error');
      } finally {
        btnRequestOtp.textContent = 'Request OTP';
      }
    });
  }

  if (btnVerifyOtp) {
    btnVerifyOtp.addEventListener('click', async () => {
      const otp = loginOtp.value.trim();
      if (otp.length !== 6) return showToast('Enter 6-digit OTP');
      
      btnVerifyOtp.textContent = 'Verifying...';
      try {
        const res = await fetch('/v1/auth/verify-otp', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({ phone: authPhone, otp })
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

  if (btnBackPhone) {
    btnBackPhone.addEventListener('click', () => {
      loginStep1.style.display = 'block';
      loginStep2.style.display = 'none';
    });
  }`
);

// 3. Replace apiFetch
const oldApiFetch = `  async function apiFetch(url, options = {}) {
    const headers = {
      'Content-Type': 'application/json',
      'x-user-role': state.currentRole,
      ...(options.headers || {}),
    };
    return fetch(url, { ...options, headers });
  }`;

const newApiFetch = `  async function apiFetch(url, options = {}) {
    const token = localStorage.getItem('token');
    const headers = {
      'Content-Type': 'application/json',
      ...(token ? { 'Authorization': \`Bearer \${token}\` } : {}),
      ...(options.headers || {}),
    };
    const res = await fetch(url, { ...options, headers });
    if (res.status === 401) {
      handleLogout();
    }
    return res;
  }`;
content = content.replace(oldApiFetch, newApiFetch);

// 4. Replace initData() at the bottom with checkAuth()
content = content.replace(/initData\(\);\s*\}\);/g, "checkAuth();\n});");

fs.writeFileSync('backend/public/app.js', content);
console.log('Modified app.js successfully');
