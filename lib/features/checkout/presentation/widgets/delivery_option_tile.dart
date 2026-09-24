import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/app_card.dart';
import '../../domain/delivery_option.dart';

/// A single selectable delivery-method row on the checkout screen.
class DeliveryOptionTile extends StatelessWidget {
  const DeliveryOptionTile({
    super.key,
    required this.option,
    required this.selected,
    required this.onTap,
  });

  final DeliveryOption option;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      color: selected ? AppColors.green.withValues(alpha: 0.08) : Colors.white,
      onTap: onTap,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  option.title,
                  style: AppTextStyles.titleMedium.copyWith(fontSize: 15),
                ),
                Text(
                  '${option.eta} • ${taka(option.fee)}',
                  style: AppTextStyles.caption,
                ),
              ],
            ),
          ),
          if (selected)  Icon(Icons.check_circle, color: AppColors.green),
        ],
      ),
    );
  }
}
