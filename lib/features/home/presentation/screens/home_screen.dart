import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/curved_header.dart';
import '../../../../core/widgets/language_switcher.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../widgets/menu_action_card.dart';

/// Main menu / dashboard screen shown after the splash screen.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CurvedHeader(
              title: l10n.homeHeaderTitle,
              subtitle: l10n.homeHeaderSubtitle,
              corner: const LanguageSwitcher(),
              trailing: AppButton(
                label: l10n.uploadPlantPhoto,
                trailingIcon: Icons.add_circle_outline,
                variant: AppButtonVariant.secondary,
                expand: true,
                onPressed: () => context.go('/ai-doctor'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.xl),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(l10n.quickActionsLabel, style: AppTextStyles.sectionLabel),
                  const SizedBox(height: AppSpacing.md),
                  Row(
                    children: [
                      Expanded(
                        child: MenuActionCard(
                          icon: Icons.eco_outlined,
                          label: l10n.maintainance,
                          color: AppColors.green,
                          onTap: () => context.go('/plants/new'),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: MenuActionCard(
                          icon: Icons.health_and_safety_outlined,
                          label: l10n.diseaseDetectionTile,
                          color: AppColors.teal,
                          onTap: () => context.go('/ai-doctor'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Row(
                    children: [
                      Expanded(
                        child: MenuActionCard(
                          icon: Icons.local_florist_outlined,
                          label: l10n.fertilizerRecipesLabel,
                          color: AppColors.orange,
                          onTap: () => context.go('/fertilizer'),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: MenuActionCard(
                          icon: Icons.storefront_outlined,
                          label: l10n.shopLabel,
                          color: AppColors.plum,
                          onTap: () {},
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xxl),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const _ChatAvatar(),
                      AppButton(
                        label: l10n.mainMenuButton,
                        variant: AppButtonVariant.outline,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChatAvatar extends StatelessWidget {
  const _ChatAvatar();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Material(
          color: AppColors.teal,
          shape: const CircleBorder(),
          elevation: 0,
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: () {},
            child: const Padding(
              padding: EdgeInsets.all(14),
              child: Icon(
                Icons.chat_bubble_outline,
                color: Colors.white,
                size: 22,
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          AppLocalizations.of(context).chatWithExpertLabel,
          style: AppTextStyles.caption,
        ),
      ],
    );
  }
}
