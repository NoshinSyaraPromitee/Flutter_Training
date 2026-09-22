import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_button.dart';

/// The "Scan Again" / "Get Care Roadmap" / "Care Guide" button stack on the
/// plant details screen.
class PlantActionButtons extends StatelessWidget {
  const PlantActionButtons({
    super.key,
    required this.onScan,
    required this.onRoadmap,
    required this.onCareGuide,
  });

  final VoidCallback onScan;
  final VoidCallback onRoadmap;
  final VoidCallback onCareGuide;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppButton(
          label: 'Scan Again',
          trailingIcon: Icons.photo_camera_outlined,
          expand: true,
          onPressed: onScan,
        ),
        const SizedBox(height: AppSpacing.md),
        AppButton(
          label: 'Get Care Roadmap',
          variant: AppButtonVariant.secondary,
          trailingIcon: Icons.map_outlined,
          expand: true,
          onPressed: onRoadmap,
        ),
        const SizedBox(height: AppSpacing.md),
        AppButton(
          label: 'Care Guide',
          variant: AppButtonVariant.outline,
          trailingIcon: Icons.eco_outlined,
          expand: true,
          onPressed: onCareGuide,
        ),
      ],
    );
  }
}
