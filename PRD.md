# VAG-DMP — Product Requirement Document

## What We're Building
A digital proof-of-work and documentation platform for Village Action Group field workers, replacing the current WhatsApp-based manual reporting system. Offline-first Flutter app (mobile for Leaders, web for Admins) built on a local Isar database with a background sync engine to the cloud.

## Target Users

**Village Action Leaders (Field Workers)**
- Women leaders operating in rural villages (client: Swayam Shikshan Prayog)
- Low-end Android phones (₹5k–10k), limited tech literacy
- Intermittent or zero internet connectivity in the field
- Primary language: Marathi (confirm if other states/languages are in scope — see Open Questions)

**NGO Supervisors (Admins)**
- Aggregate reports, verify proof (photos/documents), track KPIs across all villages
- Need a web dashboard with filtering and reporting suitable for donor/funder reports

## Core Features
- **Offline-First**: App is 100% functional without internet
- **Role-Based Access Control (RBAC)**: Separate interfaces for Leaders (mobile) and Admins (web)
- **Proof-of-Work Submission Flow**: 3-step wizard — category, action taken, before/after photos
- **Background Sync Engine**: Uploads locally stored data whenever network is detected
- **Verification Center**: Admin dashboard to filter, review, approve field submissions

## What We Have Completed (verified from build screenshots, 25 Jul 2026)

| Screen | Status | Notes |
|---|---|---|
| Leader shell/navigation | ✅ Built | Submit / History / Meetings / Profile — side nav working |
| Submit — Step 1 of 3 (Category select) | ✅ Built | Swipeable card carousel, dot pagination. Categories seen: Society & Community, Drinking Water, Road, Education |
| Submit — Step 2 (Action taken) | ❌ Not built | — |
| Submit — Step 3 (Before/after photos) | ❌ Not built | — |
| History screen | 🟡 UI only | Filter chips (All/Road/Education/Society/Water) built; empty state built; **not wired to Isar data yet** |
| Meetings screen | 🟡 UI only | Upcoming/Past tabs built; empty state built; **not wired to data yet** |
| Profile screen | 🟡 Partial | Name/role/location card built, Language setting (Marathi shown), Notifications toggle, Help & Support, About. **"Admin Mode / Developer Tools" dev toggle currently visible — must be gated before release** |
| Offline indicator | ✅ Built | "Offline Mode" banner visible in app bar — good, this matters a lot for this user base |
| Isar local DB schema | ✅ Built | Submissions, Meetings, Villages (from Phase 1 architecture) |
| Riverpod + GoRouter shell | ✅ Built | Adaptive shell for Leader/Admin roles |
| Real authentication | ❌ Not built | Role switching currently done via dev toggle, not real login |
| Cloud sync / backend | ❌ Not built | No Firebase/Supabase wiring yet |
| Admin web dashboard (verification, KPIs) | ❌ Not built (per PRD; confirm if any of this exists elsewhere) |

**Honest read: you have a real, working static UI shell (Phase 1), not yet a functioning data app.** Nothing in History/Meetings is loading from Isar yet — that's the very next thing to close before touching the backend.

## Open Questions (need client answers before scoping locks)
1. Is this a Maharashtra-only pilot, or does it need to support other states SSP operates in (Karnataka, Bihar, Kerala) with their languages?
2. Does the Admin dashboard need to produce donor/funder-facing reports (PDF/Excel exports)? SSP has active international funders (Misereor, UNDP-linked recognition) — this is likely to come up.
3. Confirmed: continuing in Flutter, no native Kotlin migration.
