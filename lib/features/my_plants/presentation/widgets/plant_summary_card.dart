import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_card.dart';
import '../../domain/plant.dart';

/// Compact row usable anywhere a short "recent plant" summary is needed.
class PlantSummaryCard extends StatelessWidget {
  const PlantSummaryCard({super.key, required this.plant});

  final Plant plant;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: () => context.push('/plants/${plant.id}'),
      child: Row(
        children: [
          Icon(Icons.local_florist, size: 36, color: AppColors.green),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(plant.nickname, style: AppTextStyles.titleMedium),
                Text(
                  'Water: ${plant.waterLevel}',
                  style: AppTextStyles.caption,
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right, color: AppColors.green),
        ],
      ),
    );
  }
}
