import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

/// Shows the plant's locally-picked photo, or a placeholder icon when none
/// was set — there's no image hosting for user photos, so this is always
/// a local file path, never a URL.
class PlantThumb extends StatelessWidget {
  const PlantThumb({
    super.key,
    this.imagePath,
    this.width = 72,
    this.height = 72,
    this.radius = 16,
  });

  final String? imagePath;
  final double width;
  final double height;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final path = imagePath;
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Container(
        width: width,
        height: height,
        color: AppColors.green.withValues(alpha: 0.08),
        alignment: Alignment.center,
        child: path == null || path.isEmpty
            ? Icon(Icons.local_florist, color: AppColors.green)
            : Image.file(
                File(path),
                width: width,
                height: height,
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}
