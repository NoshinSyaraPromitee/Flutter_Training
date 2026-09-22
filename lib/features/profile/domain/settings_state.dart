/// In-memory settings — values are held, not yet applied app-wide (no
/// notification/reminder scheduling backend exists yet).
class SettingsState {
  const SettingsState({
    this.notifications = true,
    this.wateringReminders = true,
  });

  final bool notifications;
  final bool wateringReminders;

  SettingsState copyWith({bool? notifications, bool? wateringReminders}) =>
      SettingsState(
        notifications: notifications ?? this.notifications,
        wateringReminders: wateringReminders ?? this.wateringReminders,
      );
}
