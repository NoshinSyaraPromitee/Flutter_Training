import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_card.dart';
import '../../domain/plant.dart';
import 'health_badge.dart';
import 'plant_thumb.dart';

/// A tracked plant's summary row on the "My Plants" list.
class PlantStatusCard extends StatelessWidget {
  const PlantStatusCard({super.key, required this.plant});

  final Plant plant;

  @override
  Widget build(BuildContext context) {
    Widget row(IconData icon, Color color, String text) => Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Row(
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              text,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.caption,
            ),
          ),
        ],
      ),
    );

    return AppCard(
      onTap: () => context.push('/plants/${plant.id}'),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PlantThumb(imagePath: plant.imagePath, width: 84, height: 84),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(plant.nickname, style: AppTextStyles.titleMedium),
                Text(plant.species, style: AppTextStyles.caption),
                const SizedBox(height: 6),
                HealthBadge(health: plant.health),
                row(Icons.water_drop, AppColors.teal, plant.waterLevel),
                row(
                  Icons.location_on,
                  AppColors.green,
                  plant.location.isEmpty ? '—' : plant.location,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
