import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_shadows.dart';
import '../theme/app_spacing.dart';

/// A soft-shadowed, rounded card. The shared surface treatment for info
/// boxes, list items, and form panels across the app.
class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.color,
    this.borderColor,
    this.padding = const EdgeInsets.all(AppSpacing.lg),
    this.onTap,
  });

  final Widget child;
  final Color? color;
  final Color? borderColor;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(AppRadius.md);
    final content = Padding(padding: padding, child: child);

    final surface = Material(
      color: color ?? AppColors.surface,
      borderRadius: radius,
      child: onTap != null
          ? InkWell(onTap: onTap, borderRadius: radius, child: content)
          : content,
    );

    return Container(
      decoration: BoxDecoration(
        borderRadius: radius,
        border: borderColor != null ? Border.all(color: borderColor!) : null,
        boxShadow: AppShadows.card,
      ),
      child: ClipRRect(borderRadius: radius, child: surface),
    );
  }
}
