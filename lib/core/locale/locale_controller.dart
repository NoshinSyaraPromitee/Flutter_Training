import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Riverpod-managed app locale (English / Bangla), persisted to secure
/// storage so the choice survives an app restart.
class LocaleController extends Notifier<Locale> {
  LocaleController([FlutterSecureStorage? storage])
      : _storage = storage ?? const FlutterSecureStorage();

  final FlutterSecureStorage _storage;
  static const _key = 'settings_language';

  @override
  Locale build() => const Locale('en');

  /// Call once at startup to restore the saved language.
  Future<void> load() async {
    final saved = await _storage.read(key: _key);
    if (saved == 'bn' || saved == 'en') {
      state = Locale(saved!);
    }
  }

  Future<void> setLanguage(String languageCode) async {
    state = Locale(languageCode);
    await _storage.write(key: _key, value: languageCode);
  }

  bool get isBangla => state.languageCode == 'bn';
}

final localeControllerProvider =
    NotifierProvider<LocaleController, Locale>(LocaleController.new);
