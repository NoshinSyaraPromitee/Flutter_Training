import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_card.dart';

/// "Your payment is encrypted and secure" banner on the payment screen.
class SecureCheckoutBanner extends StatelessWidget {
  const SecureCheckoutBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Row(
        children: [
           Icon(Icons.verified_user, size: 36, color: AppColors.green),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Secure Checkout',
                  style: AppTextStyles.titleMedium.copyWith(
                    color: AppColors.green,
                  ),
                ),
                Text(
                  'Your payment information is encrypted and secure.',
                  style: AppTextStyles.caption,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
