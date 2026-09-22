import 'package:plantpal/features/auth/domain/entities/auth_user.dart';

abstract class AuthRepository {
  Future<AuthUser?> restoreSession();
  Future<AuthUser?> loginWithGoogle();
  Future<void> logout();
}