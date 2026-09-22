import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/storage/secure_storage.dart';
import '../../domain/auth_user.dart';
import '../../repository/auth_repository.dart';
import '../../repository/local_auth_repository.dart';

part 'auth_providers.g.dart';

enum AuthStatus { unknown, unauthenticated, authenticated, guest }

class AuthState {
  const AuthState({this.status = AuthStatus.unknown, this.user});

  final AuthStatus status;
  final AuthUser? user;

  bool get isAllowedIn =>
      status == AuthStatus.authenticated || status == AuthStatus.guest;
  String get displayName => user?.displayName ?? 'Plant Parent';

  AuthState copyWith({AuthStatus? status, AuthUser? user}) =>
      AuthState(status: status ?? this.status, user: user ?? this.user);
}

@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) =>
    LocalAuthRepository(const SecureStorage());

/// The app's current session. `status == unknown` until [restore] resolves
/// (checked once from `main.dart` / the router's redirect logic).
@Riverpod(keepAlive: true)
class AuthController extends _$AuthController {
  @override
  AuthState build() => const AuthState();

  Future<void> restore() async {
    final user = await ref.read(authRepositoryProvider).restoreSession();
    state = AuthState(
      status: user == null
          ? AuthStatus.unauthenticated
          : AuthStatus.authenticated,
      user: user,
    );
  }

  /// Simulated sign-in: any email/name works, no backend involved.
  Future<void> signIn({String? email, String? name}) async {
    final user = await ref
        .read(authRepositoryProvider)
        .signIn(email: email ?? '', name: name);
    state = AuthState(status: AuthStatus.authenticated, user: user);
  }

  void continueAsGuest() {
    state = const AuthState(status: AuthStatus.guest);
  }

  Future<void> logout() async {
    await ref.read(authRepositoryProvider).logout();
    state = const AuthState(status: AuthStatus.unauthenticated);
  }
}
