import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../domain/plant.dart';
import 'info_box.dart';
import 'time_chip.dart';

class CareRoadmapView extends StatelessWidget {
  const CareRoadmapView({
    super.key,
    required this.plantName,
    required this.roadmap,
  });

  final String plantName;
  final CareRoadmap roadmap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            color: AppColors.green,
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.water_drop, color: Colors.white),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Text(
                  l10n.yourPlantNeeds(plantName, roadmap.waterAmountMl),
                  style: AppTextStyles.bodyText.copyWith(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: [
            for (final time in roadmap.wateringTimes) TimeChip(label: time),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        AppButton(
          label: l10n.setAlarmButton,
          leadingIcon: Icons.alarm,
          expand: true,
          onPressed: () {},
        ),
        const SizedBox(height: AppSpacing.xl),
        InfoBox(
          icon: Icons.lightbulb_outline,
          text: l10n.tipsLabel(roadmap.tips),
          color: AppColors.teal,
        ),
        const SizedBox(height: AppSpacing.md),
        InfoBox(
          icon: Icons.spa_outlined,
          text: roadmap.fertilizerRecommendation,
          color: AppColors.orange,
        ),
      ],
    );
  }
}
