import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Generic cache-with-expiry. Checks an in-memory copy first, then falls
/// back to secure storage — so cached data also survives app restarts.
class CacheManager {
  CacheManager._();
  static final CacheManager instance = CacheManager._();

  final _storage = const FlutterSecureStorage();
  final Map<String, _Entry> _memory = {};
  static const _prefix = 'cache_';

  Future<T?> read<T>(
    String key,
    T Function(dynamic json) fromJson, {
    Duration maxAge = const Duration(minutes: 5),
  }) async {
    final cached = _memory[key];
    if (cached != null && !cached.isExpired(maxAge)) return fromJson(cached.data);

    final raw = await _storage.read(key: _prefix + key);
    if (raw == null) return null;

    final decoded = jsonDecode(raw) as Map<String, dynamic>;
    final savedAt = DateTime.parse(decoded['savedAt'] as String);
    if (DateTime.now().difference(savedAt) > maxAge) return null;

    _memory[key] = _Entry(decoded['data'], savedAt);
    return fromJson(decoded['data']);
  }

  Future<void> write(String key, dynamic data) async {
    final now = DateTime.now();
    _memory[key] = _Entry(data, now);
    await _storage.write(key: _prefix + key, value: jsonEncode({'savedAt': now.toIso8601String(), 'data': data}));
  }

  /// Call after a mutation so the next read is forced fresh.
  Future<void> invalidate(String key) async {
    _memory.remove(key);
    await _storage.delete(key: _prefix + key);
  }

  /// Call on logout so the next user doesn't see cached data.
  Future<void> clear() async {
    _memory.clear();
    final all = await _storage.readAll();
    for (final k in all.keys.where((k) => k.startsWith(_prefix))) {
      await _storage.delete(key: k);
    }
  }
}

class _Entry {
  _Entry(this.data, this.savedAt);
  final dynamic data;
  final DateTime savedAt;
  bool isExpired(Duration maxAge) => DateTime.now().difference(savedAt) > maxAge;
}