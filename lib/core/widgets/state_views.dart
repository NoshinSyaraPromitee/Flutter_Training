import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';
import 'app_button.dart';

/// Shared loading/error/empty placeholders for async screens.
class LoadingView extends StatelessWidget {
  const LoadingView({super.key});
  @override
  @override
  Widget build(BuildContext context) =>
      Center(child: CircularProgressIndicator(color: AppColors.green));
}

class ErrorView extends StatelessWidget {
  const ErrorView({super.key, required this.message, this.onRetry});
  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) => EmptyView(
    icon: Icons.cloud_off_outlined,
    title: 'Something went wrong',
    subtitle: message,
    actionLabel: onRetry == null ? null : 'Try again',
    onAction: onRetry,
  );
}

class EmptyView extends StatelessWidget {
  const EmptyView({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.actionLabel,
    this.onAction,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 64, color: AppColors.textSecondary),
          const SizedBox(height: AppSpacing.md),
          Text(
            title,
            textAlign: TextAlign.center,
            style: AppTextStyles.titleLarge,
          ),
          if (subtitle != null) ...[
            const SizedBox(height: AppSpacing.xs),
            Text(
              subtitle!,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyText.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
          if (actionLabel != null) ...[
            const SizedBox(height: AppSpacing.lg),
            AppButton(label: actionLabel!, onPressed: onAction),
          ],
        ],
      ),
    ),
  );
}
