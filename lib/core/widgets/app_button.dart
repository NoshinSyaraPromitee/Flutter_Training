import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';

enum AppButtonVariant { primary, secondary, outline }

/// A bold, rounded-rectangle button — the primary action shape across the
/// app. [AppButtonVariant.primary] and [.secondary] are solid color
/// blocks; [.outline] is for lower-emphasis actions on light backgrounds.
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.trailingIcon,
    this.leadingIcon,
    this.isLoading = false,
    this.expand = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final IconData? trailingIcon;
  final IconData? leadingIcon;
  final bool isLoading;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final isEnabled = onPressed != null && !isLoading;

    final Color background;
    final Color foreground;
    final BorderSide? border;
    switch (variant) {
      case AppButtonVariant.primary:
        background = AppColors.green;
        foreground = Colors.white;
        border = null;
      case AppButtonVariant.secondary:
        background = AppColors.orange;
        foreground = Colors.white;
        border = null;
      case AppButtonVariant.outline:
        background = Colors.transparent;
        foreground = AppColors.textPrimary;
        border = BorderSide(color: AppColors.divider, width: 1.5);
    }

    final button = ElevatedButton(
      onPressed: isEnabled ? onPressed : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: background,
        foregroundColor: foreground,
        disabledBackgroundColor: variant == AppButtonVariant.outline
            ? Colors.transparent
            : background.withValues(alpha: 0.4),
        disabledForegroundColor: foreground.withValues(alpha: 0.6),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.button),
          side: border ?? BorderSide.none,
        ),
        elevation: 0,
      ),
      child: Row(
        mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isLoading) ...[
            SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation(foreground),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
          ] else if (leadingIcon != null) ...[
            Icon(leadingIcon, size: 18),
            const SizedBox(width: AppSpacing.sm),
          ],
          Text(label, textAlign: TextAlign.center, style: AppTextStyles.buttonLabel),
          if (!isLoading && trailingIcon != null) ...[
            const SizedBox(width: AppSpacing.sm),
            Icon(trailingIcon, size: 18),
          ],
        ],
      ),
    );

    return expand ? SizedBox(width: double.infinity, child: button) : button;
  }
}
