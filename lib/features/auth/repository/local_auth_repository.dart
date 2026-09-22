import 'dart:convert';

import '../../../core/storage/secure_storage.dart';
import 'auth_repository.dart';
import '../domain/auth_user.dart';

const _sessionKey = 'myplantpal.auth.session';

/// A local-only "auth" implementation: any email/name signs in, no
/// password is checked, and no token is issued — there's no auth backend
/// yet. The session is persisted to secure storage so it survives an app
/// restart.
class LocalAuthRepository implements AuthRepository {
  LocalAuthRepository(this._storage);

  final SecureStorage _storage;

  @override
  Future<AuthUser?> restoreSession() async {
    final raw = await _storage.read(_sessionKey);
    if (raw == null) return null;
    try {
      return AuthUser.fromJson(jsonDecode(raw) as Map<String, dynamic>);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<AuthUser> signIn({required String email, String? name}) async {
    final trimmedEmail = email.trim();
    final user = AuthUser(
      id: 'local-${DateTime.now().millisecondsSinceEpoch}',
      email: trimmedEmail.isEmpty ? 'guest@myplantpal.app' : trimmedEmail,
      name: name?.trim().isEmpty ?? true ? null : name!.trim(),
    );
    await _storage.write(_sessionKey, jsonEncode(user.toJson()));
    return user;
  }

  @override
  Future<void> logout() => _storage.delete(_sessionKey);
}
