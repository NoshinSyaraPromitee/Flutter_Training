import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/formatters.dart';
import '../../domain/plant.dart';
import 'plant_task_row.dart';

/// "TODAY'S CARE" section label + the plant's water/fertilizer/scan rows.
class PlantTodaysCareSection extends StatelessWidget {
  const PlantTodaysCareSection({super.key, required this.plant});

  final Plant plant;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('TODAY\'S CARE', style: AppTextStyles.sectionLabel),
        const SizedBox(height: AppSpacing.sm),
        PlantTaskRow(
          icon: Icons.check_circle,
          color: AppColors.green,
          text: 'Water: ${plant.waterLevel}',
        ),
        PlantTaskRow(
          icon: Icons.local_florist,
          color: AppColors.orange,
          text: plant.fertilizerNote.isEmpty
              ? 'No fertilizer note yet'
              : 'Fertilize: ${plant.fertilizerNote}',
        ),
        PlantTaskRow(
          icon: Icons.photo_camera_outlined,
          color: AppColors.plum,
          text: 'Last scan: ${relativeDay(plant.lastScan)}',
        ),
      ],
    );
  }
}
