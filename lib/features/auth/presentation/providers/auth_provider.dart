import 'package:flutter/foundation.dart';
import 'package:plantpal/core/network/failure.dart';
import 'package:plantpal/features/auth/domain/model/auth_user.dart';
import 'package:plantpal/features/auth/domain/repositories/auth_repository.dart';

enum AuthStatus { unknown, unauthenticated, authenticated, guest }

class AuthController extends ChangeNotifier {
  AuthController(this._repo);
  final AuthRepository _repo;

  AuthStatus status = AuthStatus.unknown;
  AuthUser? user;
  String? error;
  bool busy = false;

  bool get isAllowedIn => status == AuthStatus.authenticated || status == AuthStatus.guest;
  String get displayName => user?.displayName ?? 'Plant Parent';

  Future<void> init() async {
    try {
      user = await _repo.restoreSession();
    } catch (_) {
      user = null;
    }
    status = user == null ? AuthStatus.unauthenticated : AuthStatus.authenticated;
    notifyListeners();
  }

  /// TEMP (testing): any email/password signs in locally. No backend, no token.
  void signInLocal({String? email, String? name}) {
    final e = email?.trim() ?? '';
    final n = name?.trim() ?? '';
    user = AuthUser(
      id: 'local-test-user',
      email: e.isEmpty ? 'test@plantpal.dev' : e,
      name: n.isEmpty ? null : n,
    );
    error = null;
    status = AuthStatus.authenticated;
    notifyListeners();
  }

  Future<bool> loginWithGoogle() async {
    busy = true;
    error = null;
    notifyListeners();
    try {
      final u = await _repo.loginWithGoogle();
      if (u != null) {
        user = u;
        status = AuthStatus.authenticated;
      }
    } catch (e) {
      error = Failure.from(e).message;
    }
    busy = false;
    notifyListeners();
    return status == AuthStatus.authenticated;
  }

  /// Debug builds only (see login screen). No token, so plants/AI calls will fail.
  void continueAsGuest() {
    status = AuthStatus.guest;
    notifyListeners();
  }

  Future<void> logout() async {
    await _repo.logout();
    user = null;
    status = AuthStatus.unauthenticated;
    notifyListeners();
  }
}