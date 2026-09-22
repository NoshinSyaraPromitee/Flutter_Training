import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../domain/fertilizer.dart';

/// Scrollable list of fertilizer recipe cards.
class FertilizerList extends StatelessWidget {
  const FertilizerList({super.key, required this.items});
  final List<Fertilizer> items;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return Center(
        child: Text(
          AppLocalizations.of(context).noFertilizersFound,
          style: AppTextStyles.bodyText.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      );
    }
    return ListView.separated(
      itemCount: items.length,
      separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.md),
      itemBuilder: (context, index) => _FertilizerCard(
        fertilizer: items[index],
        color:
            AppColors.accentRotation[index % AppColors.accentRotation.length],
      ),
    );
  }
}

class _FertilizerCard extends StatelessWidget {
  const _FertilizerCard({required this.fertilizer, required this.color});
  final Fertilizer fertilizer;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.14),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.eco, size: 20, color: color),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(fertilizer.name, style: AppTextStyles.titleMedium),
                if (fertilizer.category.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(
                    fertilizer.category.toUpperCase(),
                    style: AppTextStyles.caption.copyWith(
                      color: color,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.4,
                    ),
                  ),
                ],
                const SizedBox(height: AppSpacing.sm),
                Text(fertilizer.instructions, style: AppTextStyles.bodyText),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
