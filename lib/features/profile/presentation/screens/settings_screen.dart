import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/providers/locale_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/curved_header.dart';
import '../providers/settings_providers.dart';
import '../widgets/language_picker_dialog.dart';
import '../widgets/logout_button.dart';
import '../widgets/settings_section_title.dart';
import '../widgets/settings_toggle_row.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsControllerProvider);
    final settingsCtrl = ref.read(settingsControllerProvider.notifier);
    final locale = ref.watch(appLocaleProvider);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CurvedHeader(
            title: 'Settings',
            color: AppColors.green,
            onBack: () => context.pop(),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(AppSpacing.xl),
              children: [
                const SettingsSectionTitle('Notifications'),
                AppCard(
                  padding: EdgeInsets.zero,
                  child: Column(
                    children: [
                      SettingsToggleRow(
                        icon: Icons.notifications_none,
                        color: AppColors.orange,
                        title: 'Push Notifications',
                        subtitle: 'General app updates and alerts',
                        value: settings.notifications,
                        onChanged: settingsCtrl.setNotifications,
                      ),
                      const Divider(height: 1),
                      SettingsToggleRow(
                        icon: Icons.water_drop_outlined,
                        color: AppColors.teal,
                        title: 'Watering Reminders',
                        subtitle: 'Get notified when a plant needs water',
                        value: settings.wateringReminders,
                        onChanged: settingsCtrl.setWateringReminders,
                      ),
                    ],
                  ),
                ),
                const SettingsSectionTitle('General'),
                AppCard(
                  padding: EdgeInsets.zero,
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 18,
                      backgroundColor: AppColors.green.withValues(alpha: 0.13),
                      child: const Icon(
                        Icons.translate,
                        size: 20,
                        color: AppColors.green,
                      ),
                    ),
                    title: Text(
                      'Language',
                      style: AppTextStyles.titleMedium.copyWith(fontSize: 15),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          localeDisplayName(locale),
                          style: AppTextStyles.caption,
                        ),
                        const Icon(Icons.chevron_right),
                      ],
                    ),
                    onTap: () => pickLanguage(context, ref),
                  ),
                ),
                const SettingsSectionTitle('Account'),
                const LogoutButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
