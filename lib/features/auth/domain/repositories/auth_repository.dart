import '../entities/auth_user.dart';

abstract class AuthRepository {
  Future<AuthUser?> restoreSession();
  Future<AuthUser> registerWithEmail({required String email, required String password, String? name});
  Future<AuthUser> loginWithEmail({required String email, required String password});
  Future<AuthUser?> loginWithGoogle();
  Future<void> logout();
}