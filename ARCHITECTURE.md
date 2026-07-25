# VAG-DMP — Architecture

## Tech Stack
- **Framework**: Flutter (Android APK + Web PWA for Admin)
- **Language**: Dart
- **State Management**: Riverpod (`flutter_riverpod`)
- **Navigation**: GoRouter (ShellRoute for persistent nav)
- **Local Database**: Isar (offline-first source of truth on device)
- **Cloud Backend**: **Supabase** (Postgres + Storage + Auth) — *recommended, pending final sign-off*
  - Why over Firebase: your SyncManager is custom-built on top of Isar, so Firestore's native offline cache advantage doesn't apply to you. Admin-side KPI/reporting queries (filter by district, sector, village, date range) are relational joins — much cleaner in Postgres than in Firestore's NoSQL model.
  - Risk to verify before locking in: phone-OTP SMS delivery reliability/cost in rural India via Supabase's SMS provider (Twilio/MSG91) vs. Firebase Auth's more battle-tested Indian telco integration. Test this specifically, don't assume.

## App Flow

```
Leader opens app (offline or online)
        │
        ▼
Phone number + OTP login ──► session cached locally (works offline after first login)
        │
        ▼
Submit 3-step wizard ──► written to Isar immediately (status: pending)
        │                        UI never waits on network here
        ▼
SyncManager (background) watches Isar for status=pending
        │
        ├─► compress + upload photos to Supabase Storage
        ├─► upsert row to Postgres (Submissions table)
        └─► mark Isar record status=synced
        │
        ▼
Admin Web Dashboard reads directly from Supabase (Postgres queries, no Isar involved)
```

## Sync & Conflict Strategy (the part most offline-first apps get wrong)
Key insight: each submission has exactly **one owner** (the Leader who created it). Two people are not editing the same record — so classic multi-user conflict resolution is *not* your real risk.

Your real risk is **duplicate/partial syncs** from retries (app killed mid-upload, spotty network). Fix:
- Every submission gets a **client-generated UUID** at creation time (in Isar), used as the Postgres primary key too.
- Sync is an **upsert on that UUID**, not an insert — so retrying a failed sync never creates duplicates.
- Photo uploads and the Postgres row write are two separate steps — track both independently in Isar (`photo_synced`, `record_synced`) so a partial failure resumes correctly instead of re-uploading everything.

## Folder & File Architecture (Clean Architecture, feature-first)

```
lib/
├── core/
│   ├── auth/               # RBAC, phone-OTP session handling
│   ├── database/           # Isar DB initialization
│   ├── network/            # HTTP clients (Dio) / Supabase client
│   ├── router/              # GoRouter configuration
│   ├── sync/                # Background sync engine
│   └── theme/                # Colors, fonts, Material 3 theme
│
├── features/
│   ├── admin/               # Admin dashboard & verification
│   ├── auth/                 # Login & OTP verification
│   ├── issues/                # Domain & Data layer for submissions
│   ├── meetings/          # Meeting scheduler
│   ├── profile/              # User settings & developer tools (gate behind kDebugMode)
│   ├── shell/                # Adaptive scaffold (Nav bar/rail)
│   ├── submissions/    # Leader UI for submissions
│   └── villages/           # Village directory
│
└── l10n/                      # Localization (Marathi confirmed; others pending scope)
```

Each feature subdivides into `data/` (models, repositories, data sources), `domain/` (entities, enums), `presentation/` (screens, Riverpod providers, widgets).

## Known Technical Quirk
**Isar 64-bit Web Bug**: Flutter Web doesn't handle 64-bit integers well. After `build_runner`, run `patch_isar_ids.py` to truncate Isar IDs before compiling for web. **Action item: wire this into CI so it can't be forgotten before a web build.**
