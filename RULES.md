# VAG-DMP — Rules & Guidelines

## What to Use
- **Riverpod for everything.** `ConsumerWidget` + `Ref` for all state. No `StatefulWidget` unless strictly local (animation controllers, text controllers).
- **Isar as source of truth.** UI always reads from Isar, never waits on a network call. Network happens entirely in the background via SyncManager.
- **GoRouter `ShellRoute`** for nested navigation, so the bottom nav/side nav persists across screens.
- **Phone number + OTP auth** (via Supabase Auth or MSG91/Twilio). Do not use email+password — your users are low-literacy, remembering an email/password pair is a real adoption blocker.
- **Image compression**: use `flutter_image_compress` (or equivalent). Set a hard target: **max 1080px on the longest edge, max 500KB per photo, JPEG quality ~80.** Compress before writing to Isar, not after.
- **Client-generated UUIDs** for every submission at creation time (see Architecture.md — this is what makes sync retries safe).

## What to Avoid
- **Direct API calls from the UI.** Never block a user with a loading spinner waiting for an upload. Save to Isar, return control to the user immediately, let SyncManager handle the network later.
- **Uncompressed images.** Will bloat Isar and blow through Storage costs at 850-leader scale.
- **Hardcoded strings.** Every user-facing string goes through `AppLocalizations`, even if only Marathi is live today — retrofitting localization later is much more expensive than doing it now.
- **Leaving the "Admin Mode / Developer Tools" toggle reachable in a release build.** It's currently visible on the Profile screen in your build — wrap it in `if (kDebugMode)` (or a build flavor flag) immediately. This is a real risk: a field leader tapping into "view as Admin" is a confusing (and slightly insecure) experience to ship.
- **Silent sync failures.** Every sync attempt needs to log a result (success/fail/retry count) somewhere the user or you can eventually see — a field worker in a village with no signal has no way to report "the app isn't working," so the app has to be self-diagnosing.

## Error Handling
- Wrap **every** Isar write and every SyncManager network call in try/catch. No exceptions should ever reach the UI unhandled.
- **Retry policy**: exponential backoff (e.g., 1s, 5s, 30s, 2min, then hourly), capped attempts before flagging the record as "needs attention" in a local diagnostics view rather than retrying forever silently.
- **Two-stage sync tracking per submission**: `photo_synced` and `record_synced` tracked independently in Isar, so a partial failure (photo uploaded, Postgres write failed) resumes correctly instead of re-uploading everything.
- **No remote crash reporting assumption.** Since your users are offline most of the time, don't rely on something like Sentry firing in real time — batch and upload error logs the same way you batch submission data (through SyncManager), so you actually find out about crashes that happen in the field.
