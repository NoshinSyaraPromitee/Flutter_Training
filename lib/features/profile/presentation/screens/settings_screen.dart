import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' hide Consumer;
import 'package:plantpal/core/locale/locale_controller.dart';
import 'package:plantpal/core/theme/app_colors.dart';
import 'package:plantpal/core/theme/app_text_styles.dart';
import 'package:plantpal/core/widgets/app_card.dart';
import 'package:plantpal/core/widgets/app_screen.dart';
import 'package:plantpal/features/profile/presentation/controllers/settings_controller.dart';
import 'package:plantpal/features/profile/presentation/widgets/logout_dialog.dart';
import 'package:plantpal/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

/// Settings screen. Dark mode + notification toggles are Provider-backed
/// ([SettingsController]); the language picker drives the Riverpod
/// [localeControllerProvider], which is what actually switches the app's
/// [Locale] in app/app.dart.
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  Widget _icon(IconData i, Color c) => CircleAvatar(radius: 18, backgroundColor: c.withValues(alpha: 0.13), child: Icon(i, size: 20, color: c));

  Widget _toggle(IconData i, Color c, String title, String sub, bool v, ValueChanged<bool> on) => ListTile(
        leading: _icon(i, c),
        title: Text(title, style: AppTextStyles.inter(15, w: FontWeight.w600)),
        subtitle: Text(sub, style: AppTextStyles.inter(12, c: AppColors.textMuted)),
        trailing: Switch(value: v, onChanged: on, activeThumbColor: AppColors.greenPrimary),
      );

  Future<void> _pickLanguage(BuildContext context, WidgetRef ref, String current) => showDialog<void>(
        context: context,
        builder: (ctx) => SimpleDialog(
          title: const Text('Choose Language'),
          children: [
            for (final e in SettingsController.languages.entries)
              SimpleDialogOption(
                onPressed: () {
                  ref.read(localeControllerProvider.notifier).setLanguage(e.key);
                  Navigator.pop(ctx);
                },
                child: Row(children: [
                  Expanded(child: Text(e.value)),
                  if (current == e.key) const Icon(Icons.check_circle, size: 20, color: AppColors.greenPrimary),
                ]),
              ),
          ],
        ),
      );

  void _about(BuildContext context) => showDialog<void>(
        context: context,
        builder: (ctx) => AlertDialog(
          icon: const Icon(Icons.local_florist, size: 40, color: AppColors.greenPrimary),
          title: const Text('PlantPal'),
          content: const Text('Version 1.0.0\n\nYour friendly AI gardening assistant — scan, track, and care for your plants with confidence.'),
          actions: [TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Close'))],
        ),
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = context.watch<SettingsController>();
    final t = AppLocalizations.of(context);
    final languageCode = ref.watch(localeControllerProvider).languageCode;

    return AppScreen(
      title: t.settingsTitle,
      child: ListView(padding: const EdgeInsets.only(bottom: 32), children: [
        SectionTitle(t.settingsNotifications),
        AppCard(
          padding: EdgeInsets.zero,
          child: Column(children: [
            _toggle(Icons.notifications_none, const Color(0xFFFB8C00), t.settingsNotifications, 'General app updates and alerts', s.notifications, s.setNotifications),
            const Divider(height: 1),
            _toggle(Icons.water_drop_outlined, AppColors.waterBlue, t.settingsWateringReminders, 'Get notified when a plant needs water', s.wateringReminders, s.setWateringReminders),
          ]),
        ),
        SectionTitle(t.settingsAppearance),
        AppCard(
          padding: EdgeInsets.zero,
          child: _toggle(Icons.brightness_6, const Color(0xFF5C6BC0), t.settingsDarkMode, s.darkMode ? 'On' : 'Off', s.darkMode, s.setDarkMode),
        ),
        const SectionTitle('General'),
        AppCard(
          padding: EdgeInsets.zero,
          child: Column(children: [
            ListTile(
              leading: _icon(Icons.translate, const Color(0xFF43A047)),
              title: Text(t.settingsLanguage, style: AppTextStyles.inter(15, w: FontWeight.w600)),
              trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                Text(SettingsController.languages[languageCode] ?? languageCode, style: AppTextStyles.inter(13, c: AppColors.textMuted)),
                const Icon(Icons.chevron_right),
              ]),
              onTap: () => _pickLanguage(context, ref, languageCode),
            ),
            const Divider(height: 1),
            ListTile(
              leading: _icon(Icons.info_outline, const Color(0xFF8D6E63)),
              title: const Text('About PlantPal', style: TextStyle(fontWeight: FontWeight.w600)),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => _about(context),
            ),
          ]),
        ),
        const SectionTitle('Account'),
        OutlinedButton.icon(
          onPressed: () => confirmLogout(context),
          icon: const Icon(Icons.logout, color: AppColors.danger),
          label: Text(t.settingsLogout, style: const TextStyle(color: AppColors.danger)),
          style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14), side: const BorderSide(color: AppColors.danger)),
        ),
      ]),
    );
  }
}
