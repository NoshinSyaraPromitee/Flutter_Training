import 'package:flutter/material.dart';
import 'package:plantpal/core/theme/app_colors.dart';
import 'package:plantpal/core/theme/app_text_styles.dart';
import 'package:plantpal/core/widgets/app_card.dart';
import 'package:plantpal/core/widgets/app_screen.dart';
import 'package:plantpal/features/profile/presentation/controllers/settings_controller.dart';
import 'package:plantpal/features/profile/presentation/widgets/logout_dialog.dart';
import 'package:plantpal/l10n/app_localizations.dart';
import 'package:provider/provider.dart';


class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  Widget _icon(IconData i, Color c) => CircleAvatar(
    radius: 18,
    backgroundColor: c.withValues(alpha: 0.13),
    child: Icon(i, size: 20, color: c),
  );

  Widget _toggle(
    IconData i,
    Color c,
    String title,
    String sub,
    bool v,
    ValueChanged<bool> on,
  ) => ListTile(
    leading: _icon(i, c),
    title: Text(title, style: AppTextStyles.inter(15, w: FontWeight.w600)),
    subtitle: Text(sub, style: AppTextStyles.inter(12, c: AppColors.textMuted)),
    trailing: Switch(
      value: v,
      onChanged: on,
      activeThumbColor: AppColors.greenPrimary,
    ),
  );

  Future<void> _pickLanguage(BuildContext context, SettingsController s) =>
      showDialog<void>(
        context: context,
        builder: (ctx) {
          final l10n = AppLocalizations.of(context);
          return SimpleDialog(
            title: Text(l10n.chooseLanguageTitle),
            children: [
              for (final e in SettingsController.languages.entries)
                SimpleDialogOption(
                  onPressed: () {
                    s.setLanguage(e.key);
                    Navigator.pop(ctx);
                  },
                  child: Row(
                    children: [
                      Expanded(child: Text(e.value)),
                      if (s.language == e.key)
                        const Icon(
                          Icons.check_circle,
                          size: 20,
                          color: AppColors.greenPrimary,
                        ),
                    ],
                  ),
                ),
            ],
          );
        },
      );

  void _about(BuildContext context) => showDialog<void>(
    context: context,
    builder: (ctx) {
      final l10n = AppLocalizations.of(context);
      return AlertDialog(
        icon: const Icon(
          Icons.local_florist,
          size: 40,
          color: AppColors.greenPrimary,
        ),
        title: const Text('PlantPal'),
        content: Text(l10n.aboutBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(l10n.closeButton),
          ),
        ],
      );
    },
  );

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final s = context.watch<SettingsController>();
    return AppScreen(
      title: l10n.settingsMenuLabel,
      child: ListView(
        padding: const EdgeInsets.only(bottom: 32),
        children: [
          SectionTitle(l10n.notificationsSectionTitle),
          AppCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                _toggle(
                  Icons.notifications_none,
                  const Color(0xFFFB8C00),
                  l10n.pushNotificationsLabel,
                  l10n.pushNotificationsSubtitle,
                  s.notifications,
                  s.setNotifications,
                ),
                const Divider(height: 1),
                _toggle(
                  Icons.water_drop_outlined,
                  AppColors.waterBlue,
                  l10n.wateringRemindersLabel,
                  l10n.wateringRemindersSubtitle,
                  s.wateringReminders,
                  s.setWateringReminders,
                ),
              ],
            ),
          ),
          SectionTitle(l10n.appearanceSectionTitle),
          AppCard(
            padding: EdgeInsets.zero,
            child: _toggle(
              Icons.brightness_6,
              const Color(0xFF5C6BC0),
              l10n.darkModeLabel,
              s.darkMode ? l10n.onLabel : l10n.offLabel,
              s.darkMode,
              s.setDarkMode,
            ),
          ),
          SectionTitle(l10n.generalSectionTitle),
          AppCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                ListTile(
                  leading: _icon(Icons.translate, const Color(0xFF43A047)),
                  title: Text(
                    l10n.languageLabel,
                    style: AppTextStyles.inter(15, w: FontWeight.w600),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        SettingsController.languages[s.language]!,
                        style: AppTextStyles.inter(13, c: AppColors.textMuted),
                      ),
                      const Icon(Icons.chevron_right),
                    ],
                  ),
                  onTap: () => _pickLanguage(context, s),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: _icon(Icons.info_outline, const Color(0xFF8D6E63)),
                  title: Text(
                    l10n.aboutPlantPalLabel,
                    style: AppTextStyles.inter(15, w: FontWeight.w600),
                  ),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => _about(context),
                ),
              ],
            ),
          ),
          SectionTitle(l10n.accountSectionTitle),
          OutlinedButton.icon(
            onPressed: () => confirmLogout(context),
            icon: const Icon(Icons.logout, color: AppColors.danger),
            label: Text(
              l10n.logOutButton,
              style: TextStyle(color: AppColors.danger),
            ),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
              side: const BorderSide(color: AppColors.danger),
            ),
          ),
        ],
      ),
    );
  }
}
