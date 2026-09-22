/// A signed-in user. There's no auth backend yet (see CLAUDE.md phase 2),
/// so this is populated by [LocalAuthRepository] rather than a real API.
class AuthUser {
  const AuthUser({required this.id, required this.email, this.name});

  final String id;
  final String email;
  final String? name;

  String get displayName {
    final trimmed = name?.trim();
    if (trimmed != null && trimmed.isNotEmpty) return trimmed;
    final local = email.split('@').first;
    return local.isEmpty
        ? 'Plant Parent'
        : local[0].toUpperCase() + local.substring(1);
  }

  Map<String, dynamic> toJson() => {'id': id, 'email': email, 'name': name};

  factory AuthUser.fromJson(Map<String, dynamic> json) => AuthUser(
    id: json['id'] as String,
    email: json['email'] as String,
    name: json['name'] as String?,
  );
}
