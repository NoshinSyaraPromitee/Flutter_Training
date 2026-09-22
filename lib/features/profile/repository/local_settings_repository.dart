import 'settings_repository.dart';
import '../domain/settings_state.dart';

/// No user-preferences backend yet (see CLAUDE.md: `Users` collection) —
/// every session starts with the same defaults.
class LocalSettingsRepository implements SettingsRepository {
  @override
  SettingsState initial() => const SettingsState();
}
