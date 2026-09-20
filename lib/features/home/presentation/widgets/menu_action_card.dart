import 'package:flutter/material.dart';

import '../../../../core/widgets/app_button.dart';

/// An illustration with a label button underneath it, used for the
/// Maintenance / Disease Detection / Shop tiles on the home screen.
class MenuActionCard extends StatelessWidget {
  const MenuActionCard({
    super.key,
    required this.imageAsset,
    required this.label,
    this.variant = AppButtonVariant.green,
    this.onTap,
  });

  final String imageAsset;
  final String label;
  final AppButtonVariant variant;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 110, width: 130, child: Image.asset(imageAsset)),
        const SizedBox(height: 8),
        AppButton(label: label, variant: variant, onPressed: onTap),
      ],
    );
  }
}
