import 'package:flutter/material.dart';

import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_spacing.dart';

/// A bold color-block card used to show a diagnosis result's issue/cure,
/// on the Scan Result screen.
class DiagnosisResultBox extends StatelessWidget {
  const DiagnosisResultBox({
    super.key,
    required this.icon,
    required this.text,
    required this.color,
  });

  final IconData icon;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(AppRadius.sm),
        boxShadow: AppShadows.tinted(color),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.white, size: 22),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15.5,
                height: 1.4,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
