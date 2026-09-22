import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:plantpal/core/theme/app_colors.dart';

class ShimmerBox extends StatelessWidget {
  const ShimmerBox({super.key, this.width, this.height = 16, this.radius = 8});
  final double? width;
  final double height;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.textMuted.withValues(alpha: 0.15),
      highlightColor: AppColors.textMuted.withValues(alpha: 0.05),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(radius)),
      ),
    );
  }
}

class ShimmerListPlaceholder extends StatelessWidget {
  const ShimmerListPlaceholder({super.key, this.itemCount = 4, this.itemHeight = 84});
  final int itemCount;
  final double itemHeight;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: itemCount,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (_, _) => ShimmerBox(width: double.infinity, height: itemHeight, radius: 16),
    );
  }
}

