import 'dart:convert';

import 'package:plantpal/core/network/failure.dart';
import 'package:plantpal/core/storage/secure_storage.dart';
import 'package:plantpal/core/utils/jwt.dart';
import 'package:plantpal/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:plantpal/features/auth/domain/entities/auth_user.dart';
import 'package:plantpal/features/auth/domain/repositories/auth_repository.dart';

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
  Future<AuthUser?> loginWithGoogle() => guardCall(() async {
        final jwt = await _remote.googleLogin();
        if (jwt == null) return null;
        final p = decodeJwtPayload(jwt);
        final user = AuthUser(id: p['userId'].toString(), email: p['email'].toString(), name: p['name'] as String?);
        await _storage.saveSession(jwt, jsonEncode(user.toJson()));
        return user;
      });

  @override
  Future<void> logout() => _storage.clear();
}