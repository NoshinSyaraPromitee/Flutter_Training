import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class HealthBadge extends StatelessWidget {
  const HealthBadge({super.key, this.health});

  final int? health;

  @override
  Widget build(BuildContext context) {
    final h = health;
    final Color color;
    final String text;
    if (h == null) {
      color = AppColors.textSecondary;
      text = 'Not scanned yet';
    } else if (h < 60) {
      color = AppColors.danger;
      text = '$h% • Critical';
    } else if (h < 85) {
      color = AppColors.orange;
      text = '$h% • Needs Care';
    } else {
      color = AppColors.green;
      text = '$h% • Healthy';
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        text,
        style: AppTextStyles.caption.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
