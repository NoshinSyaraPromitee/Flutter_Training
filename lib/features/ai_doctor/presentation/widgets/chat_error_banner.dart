import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';

/// Inline error row shown above the chat thread when sending/loading fails.
class ChatErrorBanner extends StatelessWidget {
  const ChatErrorBanner({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xl,
        vertical: AppSpacing.sm,
      ),
      child: Row(
        children: [
          const Icon(Icons.error_outline, color: AppColors.danger, size: 18),
          const SizedBox(width: AppSpacing.xs),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(color: AppColors.danger, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}
