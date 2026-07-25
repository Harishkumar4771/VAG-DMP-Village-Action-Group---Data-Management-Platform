/// User roles for the VAG-DMP application.
/// Controls which navigation shell and screens are displayed.
enum UserRole { leader, admin }

/// Represents the currently authenticated user.
class AppUser {
  final String id;
  final String name;
  final String initials;
  final UserRole role;
  final String? villageId;
  final String? villageName;
  final String phone;

  const AppUser({
    required this.id,
    required this.name,
    required this.initials,
    required this.role,
    this.villageId,
    this.villageName,
    required this.phone,
  });

  AppUser copyWith({
    String? id,
    String? name,
    String? initials,
    UserRole? role,
    String? villageId,
    String? villageName,
    String? phone,
  }) {
    return AppUser(
      id: id ?? this.id,
      name: name ?? this.name,
      initials: initials ?? this.initials,
      role: role ?? this.role,
      villageId: villageId ?? this.villageId,
      villageName: villageName ?? this.villageName,
      phone: phone ?? this.phone,
    );
  }
}
