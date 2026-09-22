import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_card.dart';

/// Prompts a guest-mode user to create an account.
class GuestBanner extends StatelessWidget {
  const GuestBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.lg),
      child: AppCard(
        color: AppColors.orange.withValues(alpha: 0.1),
        child: Row(
          children: [
            Icon(Icons.info_outline, color: AppColors.orange),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Text(
                "You're browsing as a guest. Create an account to keep your plants and progress.",
                style: AppTextStyles.bodyText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
