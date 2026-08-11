const fs = require('fs');
let content = fs.readFileSync('backend/public/app.js', 'utf8');

// 1. Replace apiFetch
const oldApiFetch = `  async function apiFetch(url, options = {}) {
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

const newApiFetch = `  async function apiFetch(url, options = {}) {
    const headers = {
      'Content-Type': 'application/json',
      'x-user-role': state.currentRole,
      ...(options.headers || {}),
    };
    return fetch(url, { ...options, headers });
  }`;
content = content.replace(oldApiFetch, newApiFetch);

// 2. Remove Auth Elements from DOM elements block and add back roleSelect
content = content.replace(/\/\/ Auth Elements[\s\S]*?let authPhone = '';/m, 
  "const roleSelect = document.getElementById('role-switch');"
);

// 3. Remove Auth logic block and add back role switching logic
content = content.replace(/\/\/ --- AUTH LOGIC ---[\s\S]*?\/\/ --- SYNC ENGINE TOGGLE ---/m, 
  `// --- ROLE SWITCHING ---
  if (roleSelect) {
    roleSelect.addEventListener('change', (e) => {
      state.currentRole = e.target.value;
      showToast(\`Role switched to \${state.currentRole === 'ADMIN' ? 'Admin Verifier' : 'Village Leader'}\`);
      
      const adminNav = document.getElementById('admin-nav-link');
      if (adminNav) {
        adminNav.style.display = state.currentRole === 'ADMIN' ? 'flex' : 'none';
      }
      
      renderVerificationList();
    });
  }

  // --- SYNC ENGINE TOGGLE ---`
);

// 4. Change checkAuth(); at the bottom to initData();
content = content.replace(/checkAuth\(\);\s*\}\);/g, "initData();\n});");

fs.writeFileSync('backend/public/app.js', content);
console.log('Removed Auth from app.js successfully');
