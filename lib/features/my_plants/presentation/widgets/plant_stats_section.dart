import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/plant.dart';
import 'plant_fact_tile.dart';

/// The two rows of fact tiles (water/sunlight, location/humidity) on the
/// plant details screen.
class PlantStatsSection extends StatelessWidget {
  const PlantStatsSection({super.key, required this.plant});

  final Plant plant;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            PlantFactTile(
              icon: Icons.water_drop,
              color: AppColors.teal,
              title: 'Water',
              value: plant.waterLevel,
            ),
            PlantFactTile(
              icon: Icons.wb_sunny,
              color: AppColors.orange,
              title: 'Sunlight',
              value: plant.sunlight,
            ),
          ],
        ),
        Row(
          children: [
            PlantFactTile(
              icon: Icons.location_on,
              color: AppColors.green,
              title: 'Location',
              value: plant.location,
            ),
            PlantFactTile(
              icon: Icons.opacity,
              color: AppColors.teal,
              title: 'Humidity',
              value: plant.humidity,
            ),
          ],
        ),
      ],
    );
  }
}
