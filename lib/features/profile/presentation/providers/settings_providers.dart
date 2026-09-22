import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/settings_state.dart';
import '../../repository/local_settings_repository.dart';
import '../../repository/settings_repository.dart';

part 'settings_providers.g.dart';

@Riverpod(keepAlive: true)
SettingsRepository settingsRepository(Ref ref) => LocalSettingsRepository();

@Riverpod(keepAlive: true)
class SettingsController extends _$SettingsController {
  @override
  SettingsState build() => ref.watch(settingsRepositoryProvider).initial();

  void setNotifications(bool value) =>
      state = state.copyWith(notifications: value);
  void setWateringReminders(bool value) =>
      state = state.copyWith(wateringReminders: value);
}
