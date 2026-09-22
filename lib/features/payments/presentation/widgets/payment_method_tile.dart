import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_card.dart';
import '../../domain/payment_method.dart';

/// A single selectable payment-method row on the payment screen.
class PaymentMethodTile extends StatelessWidget {
  const PaymentMethodTile({
    super.key,
    required this.method,
    required this.selected,
    required this.onTap,
  });

  final PaymentMethod method;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      color: selected ? AppColors.green.withValues(alpha: 0.08) : Colors.white,
      onTap: onTap,
      child: Row(
        children: [
          Icon(
            method.icon,
            size: 26,
            color: selected ? AppColors.green : Colors.black54,
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(
              method.title,
              style: AppTextStyles.bodyText.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          if (selected)  Icon(Icons.check_circle, color: AppColors.green),
        ],
      ),
    );
  }
}
