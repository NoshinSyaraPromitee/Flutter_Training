import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  const SecureStorage([this._s = const FlutterSecureStorage()]);
  final FlutterSecureStorage _s;

  Future<String?> readToken() => _s.read(key: 'authToken');
  Future<String?> readUser() => _s.read(key: 'authUser');

  Future<void> saveSession(String token, String userJson) async {
    await _s.write(key: 'authToken', value: token);
    await _s.write(key: 'authUser', value: userJson);
  }

  Future<void> clear() async {
    await _s.delete(key: 'authToken');
    await _s.delete(key: 'authUser');
  }
}