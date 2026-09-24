import 'dart:convert';

import '../../../../core/network/failure.dart';
import '../../../../core/storage/secure_storage.dart';
import '../../../../core/utils/jwt.dart';
import '../datasources/auth_remote_data_source.dart';
import '../../domain/entities/auth_user.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._remote, this._storage);
  final AuthRemoteDataSource _remote;
  final SecureStorage _storage;

  @override
  Future<AuthUser?> restoreSession() async {
    final token = await _storage.readToken();
    final user = await _storage.readUser();
    if (token == null || user == null) return null;
    return AuthUser.fromJson(jsonDecode(user) as Map<String, dynamic>);
  }

  @override
  Future<AuthUser> registerWithEmail({required String email, required String password, String? name}) =>
      guardCall(() async {
        final t = await _remote.register(email: email, password: password, name: name);
        final user = AuthUser.fromJson(t.userJson);
        await _storage.saveSession(t.accessToken, jsonEncode(user.toJson()), refreshToken: t.refreshToken);
        return user;
      });

  @override
  Future<AuthUser> loginWithEmail({required String email, required String password}) => guardCall(() async {
        final t = await _remote.login(email: email, password: password);
        final user = AuthUser.fromJson(t.userJson);
        await _storage.saveSession(t.accessToken, jsonEncode(user.toJson()), refreshToken: t.refreshToken);
        return user;
      });

  @override
  Future<AuthUser?> loginWithGoogle() => guardCall(() async {
        final jwt = await _remote.googleLogin();
        if (jwt == null) return null;
        final p = decodeJwtPayload(jwt);
        final user = AuthUser(id: p['userId'].toString(), email: p['email'].toString(), name: p['name'] as String?);
        await _storage.saveSession(jwt, jsonEncode(user.toJson()));
        return user;
      });

  @override
  Future<void> logout() async {
    final refreshToken = await _storage.readRefreshToken();
    if (refreshToken != null) {
      try {
        await _remote.logout(refreshToken);
      } catch (_) {
        // Local logout still succeeds if the server is unavailable.
      }
    }
    await _storage.clear();
  }
}