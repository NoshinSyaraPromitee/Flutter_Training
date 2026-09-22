import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

/// One fact tile ("Water: 60%") used two-per-row on the plant details screen.
class PlantFactTile extends StatelessWidget {
  const PlantFactTile({
    super.key,
    required this.icon,
    required this.color,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final Color color;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(4),
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        child: Column(
          children: [
            Icon(icon, size: 26, color: color),
            const SizedBox(height: AppSpacing.xs),
            Text(
              title,
              style: AppTextStyles.caption.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              value.isEmpty ? '—' : value,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyText.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
