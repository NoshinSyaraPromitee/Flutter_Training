import '../domain/auth_user.dart';

/// Persists the (simulated, local-only) auth session. Swap
/// [LocalAuthRepository] for a real backend-backed implementation once
/// auth exists server-side — nothing above this interface needs to change.
abstract class AuthRepository {
  Future<AuthUser?> restoreSession();
  Future<AuthUser> signIn({required String email, String? name});
  Future<void> logout();
}
