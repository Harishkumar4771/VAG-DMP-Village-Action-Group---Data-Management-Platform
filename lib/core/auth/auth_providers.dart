import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'user_role.dart';

/// Mock Leader user — default on app start.
const _mockLeader = AppUser(
  id: 'leader-001',
  name: 'Sunita Kumar',
  initials: 'SK',
  role: UserRole.leader,
  villageId: 'village-chandpur',
  villageName: 'Chandpur',
  phone: '+91 98765 43210',
);

/// Mock Admin user — used when RBAC toggle is switched.
const _mockAdmin = AppUser(
  id: 'admin-001',
  name: 'Priya Deshmukh',
  initials: 'PD',
  role: UserRole.admin,
  villageId: null,
  villageName: null,
  phone: '+91 98765 00001',
);

/// The currently authenticated user. Mutable for RBAC toggle testing.
final currentUserProvider = StateProvider<AppUser>((ref) => _mockLeader);

/// Convenience provider: current user's role.
final userRoleProvider = Provider<UserRole>((ref) {
  return ref.watch(currentUserProvider).role;
});

/// Convenience provider: is the current user an admin?
final isAdminProvider = Provider<bool>((ref) {
  return ref.watch(userRoleProvider) == UserRole.admin;
});

/// Returns the mock admin user for toggling.
AppUser get mockAdminUser => _mockAdmin;

/// Returns the mock leader user for toggling.
AppUser get mockLeaderUser => _mockLeader;
