import 'package:flutter/foundation.dart';

/// In-memory for now: values are stored, not yet applied app-wide.
class SettingsController extends ChangeNotifier {
  bool notifications = true;
  bool wateringReminders = true;
  bool darkMode = false;
  String language = 'en';

  static const languages = {'en': 'English', 'bn': 'বাংলা (Bangla)'};

  void setNotifications(bool v) => _set(() => notifications = v);
  void setWateringReminders(bool v) => _set(() => wateringReminders = v);
  void setDarkMode(bool v) => _set(() => darkMode = v);
  void setLanguage(String code) => _set(() => language = code);

  void _set(VoidCallback change) {
    change();
    notifyListeners();
  }
}