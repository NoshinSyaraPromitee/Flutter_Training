import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:plantpal/core/theme/app_colors.dart';

class SettingsController extends ChangeNotifier {
  SettingsController([this._storage = const FlutterSecureStorage()]);
  final FlutterSecureStorage _storage;
  static const _darkModeKey = 'settings_dark_mode';

  bool notifications = true;
  bool wateringReminders = true;
  bool darkMode = false;
  String language = 'en';

  static const languages = {'en': 'English', 'bn': 'à¦¬à¦¾à¦‚à¦²à¦¾ (Bangla)'};

  /// Call once at startup to restore the saved theme.
  Future<void> load() async {
    final saved = await _storage.read(key: _darkModeKey);
    darkMode = saved == 'true';
    AppColors.isDark = darkMode;
    notifyListeners();
  }

  void setNotifications(bool v) => _set(() => notifications = v);
  void setWateringReminders(bool v) => _set(() => wateringReminders = v);

  void setDarkMode(bool v) {
    darkMode = v;
    AppColors.isDark = v;
    _storage.write(key: _darkModeKey, value: v.toString());
    notifyListeners();
  }

  void setLanguage(String code) => _set(() => language = code);

  ThemeMode get themeMode => darkMode ? ThemeMode.dark : ThemeMode.light;

  void _set(VoidCallback change) {
    change();
    notifyListeners();
  }
}
