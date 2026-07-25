# VAG-DMP — Execution Phases

Because of processing/time limits, the project is strictly divided into achievable phases. Phases below are re-baselined against what's actually verified as built (per screenshots, 25 Jul 2026) — not what was assumed complete.

## Phase 1: Static UI Foundation — ✅ Mostly Complete
- App scaffolding, Isar DB schema, RBAC folder structure, GoRouter navigation
- Leader shell: Submit / History / Meetings / Profile screens built
- Submit Step 1 of 3 (category selection) working with carousel UI
- Empty states for History and Meetings built
- Offline Mode indicator built
- **Remaining to close out Phase 1**: gate the dev "Admin Mode" toggle behind `kDebugMode`

## Phase 2: Data Wiring & Submission Flow Completion — 📍 We are here
- Build Submit Step 2 (action taken) and Step 3 (before/after photos)
- Wire History screen to actually query and display Isar submissions (currently static empty state)
- Wire Meetings screen to actually query Isar meetings (currently static empty state)
- Implement image compression pipeline (see Rules.md for exact targets)
- Assign client-generated UUID to every new submission at creation

## Phase 3: Real Auth + Cloud Sync
- Finalize backend decision (Supabase vs Firebase) — **do this first, it blocks everything else in this phase**
- Set up Postgres schema (Submissions, Meetings, Villages) + Storage buckets
- Implement phone-OTP authentication, replacing the current dev role toggle
- Build SyncManager: watch Isar `pending` → upload photo → upsert Postgres row → mark `synced`
- Implement retry/backoff and two-stage sync tracking (photo vs record)

## Phase 4: Hardware Integration & Localization
- Real camera/gallery picker (replacing any placeholder photo flow)
- GPS tagging for proof-of-work validity
- Localization: Marathi is confirmed; **confirm with client whether Hindi/Kannada/Malayalam are in scope** before building the l10n framework, since retrofitting more languages later is cheap once the framework exists but expensive to redo the framework itself

## Phase 5: Admin Dashboard & Release
- Verification Center: filter, review, approve submissions against real data
- KPI dashboard queries (by village/district/sector/date range)
- Donor/funder-facing report export (PDF/Excel) — **confirm with client if required**
- Build optimized Android App Bundle (AAB)
- Deploy Admin Dashboard (Firebase Hosting or Vercel, depending on final backend choice)
- Set up CI/CD (including the Isar web-ID patch script as a required build step)
- Field testing

## Definition of Done for "Not Designed / Not Ending" Items
Any feature without an explicit spec (exact compression size, exact retry timing, exact language list) blocks its phase from being marked complete — a vague "we'll compress images" is not a finished spec, it's a placeholder. Each phase above should not start until its predecessor's specs are locked, not just its code.
