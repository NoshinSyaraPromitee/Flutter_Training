import 'package:json_annotation/json_annotation.dart';

part 'auth_user.g.dart';

/// Run `dart run build_runner build --delete-conflicting-outputs` after
/// editing this class to regenerate auth_user.g.dart.
@JsonSerializable()
class AuthUser {
  const AuthUser({required this.id, required this.email, this.name});

  final String id;
  final String email;
  final String? name;

  String get displayName {
    final n = name?.trim();
    if (n != null && n.isNotEmpty) return n;
    final local = email.split('@').first;
    return local.isEmpty ? 'Plant Parent' : local[0].toUpperCase() + local.substring(1);
  }

  factory AuthUser.fromJson(Map<String, dynamic> json) => _$AuthUserFromJson(json);
  Map<String, dynamic> toJson() => _$AuthUserToJson(this);
}
