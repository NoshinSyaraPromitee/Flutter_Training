import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/curved_header.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../domain/diagnosis.dart';
import '../widgets/diagnosis_card.dart';

/// Shows the result of a photo submitted on [ScanPlantScreen] (route
/// `/scan-result`, pushed with `extra: diagnosis`).
class ScanResultScreen extends StatelessWidget {
  const ScanResultScreen({super.key, required this.diagnosis});

  final Diagnosis diagnosis;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CurvedHeader(
              title: l10n.diseasesDetectionHeader,
              color: AppColors.teal,
              onBack: () =>
                  context.canPop() ? context.pop() : context.go('/scan'),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.xl),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DiagnosisResultBox(
                    icon: Icons.warning_amber_rounded,
                    text: diagnosis.issue,
                    color: AppColors.danger,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  DiagnosisResultBox(
                    icon: Icons.healing_outlined,
                    text: l10n.cureLabel(diagnosis.cure),
                    color: AppColors.cure,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.info_outline,
                        size: 15,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      Expanded(
                        child: Text(
                          diagnosis.disclaimer,
                          style: AppTextStyles.caption,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: AppButton(
                          label: l10n.addToLogButton,
                          variant: AppButtonVariant.secondary,
                          leadingIcon: Icons.bookmark_add_outlined,
                          onPressed: () {},
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: AppButton(
                          label: l10n.buyFertilizerButton,
                          leadingIcon: Icons.storefront_outlined,
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  AppButton(
                    label: 'Scan Another Photo',
                    variant: AppButtonVariant.outline,
                    expand: true,
                    onPressed: () => context.go('/scan'),
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
