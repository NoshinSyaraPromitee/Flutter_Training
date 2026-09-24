import 'package:plantpal/features/auth/domain/model/auth_user.dart';

abstract class AuthRepository {
  Future<AuthUser?> restoreSession();
  Future<AuthUser?> loginWithGoogle();
  Future<void> logout();
}