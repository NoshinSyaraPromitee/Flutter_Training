import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_shadows.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';

/// A bold, color-blocked header with rounded bottom corners. This is the
/// consistent top-of-screen treatment across the app — a confident solid
/// color block instead of a continuous pastel gradient wash.
class CurvedHeader extends StatelessWidget {
  const CurvedHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.color = AppColors.green,
    this.trailing,
    this.corner,
    this.onBack,
  });

  final String title;
  final String? subtitle;
  final Color color;
  final Widget? trailing;
  final Widget? corner;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(AppRadius.lg),
          bottomRight: Radius.circular(AppRadius.lg),
        ),
        boxShadow: AppShadows.tinted(color),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.xl,
            AppSpacing.sm,
            AppSpacing.xl,
            AppSpacing.xl,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (onBack != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                  child: InkWell(
                    onTap: onBack,
                    borderRadius: BorderRadius.circular(999),
                    child: const Padding(
                      padding: EdgeInsets.all(4),
                      child: Icon(
                        Icons.arrow_back_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title, style: AppTextStyles.displayMedium),
                        if (subtitle != null) ...[
                          const SizedBox(height: AppSpacing.xs),
                          Text(
                            subtitle!,
                            style: AppTextStyles.bodyText.copyWith(
                              color: Colors.white.withValues(alpha: 0.85),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  ?corner,
                ],
              ),
              if (trailing != null) ...[
                const SizedBox(height: AppSpacing.lg),
                trailing!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}
