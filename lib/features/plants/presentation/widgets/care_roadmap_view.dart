import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../domain/plant.dart';
import '../../domain/weather_tip.dart';
import '../providers/weather_tip_providers.dart';
import 'info_box.dart';
import 'time_chip.dart';

class CareRoadmapView extends ConsumerWidget {
  const CareRoadmapView({
    super.key,
    required this.plantName,
    required this.roadmap,
  });

  final String plantName;
  final CareRoadmap roadmap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final weatherTip = ref.watch(weatherTipProvider(roadmap.waterAmountMl));
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
        if (weatherTip != null) ...[
          InfoBox(
            icon: _weatherTipIcon(weatherTip.kind),
            text: _weatherTipText(l10n, weatherTip),
            color: AppColors.danger,
          ),
          const SizedBox(height: AppSpacing.md),
        ],
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

IconData _weatherTipIcon(WeatherTipKind kind) {
  switch (kind) {
    case WeatherTipKind.hot:
      return Icons.wb_sunny_outlined;
    case WeatherTipKind.cold:
      return Icons.ac_unit;
    case WeatherTipKind.wetOutside:
      return Icons.water_outlined;
  }
}

String _weatherTipText(AppLocalizations l10n, WeatherTip tip) {
  switch (tip.kind) {
    case WeatherTipKind.hot:
      return l10n.weatherTipHot(tip.suggestedWaterMl!);
    case WeatherTipKind.cold:
      return l10n.weatherTipCold;
    case WeatherTipKind.wetOutside:
      return l10n.weatherTipWetOutside;
  }
}
