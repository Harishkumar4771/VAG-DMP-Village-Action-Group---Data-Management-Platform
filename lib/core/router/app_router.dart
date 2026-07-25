import 'package:go_router/go_router.dart';

import '../../features/auth/screens/login_screen.dart';
import '../../features/auth/screens/forgot_password_screen.dart';
import '../../features/shell/screens/app_shell.dart';

// Leader screens
import '../../features/submissions/screens/submission_flow_screen.dart';
import '../../features/submissions/screens/submission_history_screen.dart';
import '../../features/submissions/screens/submission_detail_screen.dart';
import '../../features/meetings/screens/meeting_list_screen.dart';
import '../../features/meetings/screens/create_meeting_screen.dart';
import '../../features/meetings/screens/meeting_detail_screen.dart';

// Admin screens
import '../../features/admin/screens/admin_dashboard_screen.dart';
import '../../features/admin/screens/verification_center_screen.dart';
import '../../features/admin/screens/admin_review_screen.dart';
import '../../features/admin/screens/admin_notifications_screen.dart';
import '../../features/villages/screens/village_list_screen.dart';
import '../../features/villages/screens/village_detail_screen.dart';

// Shared
import '../../features/profile/screens/profile_screen.dart';

/// GoRouter configuration for the VAG-DMP v2 app.
/// Two separate ShellRoutes for Leader and Admin roles.
final GoRouter appRouter = GoRouter(
  initialLocation: '/login',
  debugLogDiagnostics: true,
  routes: [
    // ── Authentication Routes ───────────────────────────────────
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/forgot-password',
      name: 'forgot-password',
      builder: (context, state) => const ForgotPasswordScreen(),
    ),

    // ── Leader Shell ────────────────────────────────────────────
    ShellRoute(
      builder: (context, state, child) => AppShell(child: child),
      routes: [
        GoRoute(
          path: '/leader/submit',
          name: 'leader-submit',
          builder: (context, state) => const SubmissionFlowScreen(),
        ),
        GoRoute(
          path: '/leader/history',
          name: 'leader-history',
          builder: (context, state) => const SubmissionHistoryScreen(),
          routes: [
            GoRoute(
              path: ':submissionId',
              name: 'submission-detail',
              builder: (context, state) {
                final submissionId = state.pathParameters['submissionId']!;
                return SubmissionDetailScreen(submissionId: submissionId);
              },
            ),
          ],
        ),
        GoRoute(
          path: '/leader/meetings',
          name: 'leader-meetings',
          builder: (context, state) => const MeetingListScreen(),
          routes: [
            GoRoute(
              path: 'create',
              name: 'leader-create-meeting',
              builder: (context, state) => const CreateMeetingScreen(),
            ),
            GoRoute(
              path: ':meetingId',
              name: 'leader-meeting-detail',
              builder: (context, state) {
                final meetingId = state.pathParameters['meetingId']!;
                return MeetingDetailScreen(meetingId: meetingId);
              },
            ),
          ],
        ),
        GoRoute(
          path: '/leader/profile',
          name: 'leader-profile',
          builder: (context, state) => const ProfileScreen(),
        ),
      ],
    ),

    // ── Admin Shell ─────────────────────────────────────────────
    ShellRoute(
      builder: (context, state, child) => AppShell(child: child),
      routes: [
        GoRoute(
          path: '/admin/dashboard',
          name: 'admin-dashboard',
          builder: (context, state) => const AdminDashboardScreen(),
        ),
        GoRoute(
          path: '/admin/verify',
          name: 'admin-verify',
          builder: (context, state) => const VerificationCenterScreen(),
          routes: [
            GoRoute(
              path: ':submissionId',
              name: 'admin-review',
              builder: (context, state) {
                final submissionId = state.pathParameters['submissionId']!;
                return AdminReviewScreen(submissionId: submissionId);
              },
            ),
          ],
        ),
        GoRoute(
          path: '/admin/notifications',
          name: 'admin-notifications',
          builder: (context, state) => const AdminNotificationsScreen(),
        ),
        GoRoute(
          path: '/admin/villages',
          name: 'admin-villages',
          builder: (context, state) => const VillageListScreen(),
          routes: [
            GoRoute(
              path: ':villageId',
              name: 'admin-village-detail',
              builder: (context, state) {
                final villageId = state.pathParameters['villageId']!;
                return VillageDetailScreen(villageId: villageId);
              },
            ),
          ],
        ),
        GoRoute(
          path: '/admin/profile',
          name: 'admin-profile',
          builder: (context, state) => const ProfileScreen(),
        ),
      ],
    ),
  ],
);
