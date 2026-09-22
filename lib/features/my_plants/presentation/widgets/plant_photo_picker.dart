import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import 'plant_thumb.dart';

/// Tappable photo placeholder / preview used on the add-plant form.
class PlantPhotoPicker extends StatelessWidget {
  const PlantPhotoPicker({
    super.key,
    required this.imagePath,
    required this.onTap,
  });

  final String? imagePath;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: imagePath == null
          ? Container(
              height: 160,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(AppRadius.md),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_a_photo, size: 48, color: AppColors.green),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'Add Plant Photo',
                    style: AppTextStyles.titleMedium.copyWith(
                      color: AppColors.green,
                    ),
                  ),
                ],
              ),
            )
          : PlantThumb(
              imagePath: imagePath,
              width: double.infinity,
              height: 160,
              radius: AppRadius.md,
            ),
    );
  }
}
