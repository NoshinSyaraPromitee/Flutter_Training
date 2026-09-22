import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Riverpod-managed app locale (English / Bangla), persisted to secure
/// storage so the choice survives an app restart.
///
/// Kept separate from [SettingsController] (Provider, theme/notifications)
/// on purpose: this project uses Provider for feature-level state and
/// Riverpod for this piece of cross-cutting app state, per the project
/// requirements.
class LocaleController extends StateNotifier<Locale> {
  LocaleController([FlutterSecureStorage? storage])
      : _storage = storage ?? const FlutterSecureStorage(),
        super(const Locale('en'));

  final FlutterSecureStorage _storage;
  static const _key = 'settings_language';

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

final localeControllerProvider = StateNotifierProvider<LocaleController, Locale>((ref) {
  return LocaleController();
});
