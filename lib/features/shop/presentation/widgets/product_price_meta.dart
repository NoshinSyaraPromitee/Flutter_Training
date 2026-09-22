import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/formatters.dart';
import '../../domain/product.dart';

/// Category, rating/stock, and price/unit block on the product details
/// screen.
class ProductPriceMeta extends StatelessWidget {
  const ProductPriceMeta({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(product.category, style: AppTextStyles.caption),
        const SizedBox(height: AppSpacing.xs),
        Row(
          children: [
            const Icon(Icons.star, color: Colors.amber, size: 20),
            const SizedBox(width: 4),
            Text(
              '${product.rating}',
              style: AppTextStyles.bodyText.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(width: 6),
            Text('• ${product.stock} in stock', style: AppTextStyles.caption),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: [
            Text(
              taka(product.price),
              style: AppTextStyles.displayMedium.copyWith(
                fontSize: 24,
                color: AppColors.orange,
              ),
            ),
            if (product.unit != null) ...[
              const SizedBox(width: AppSpacing.sm),
              Chip(
                label: Text(product.unit!),
                backgroundColor: AppColors.green.withValues(alpha: 0.1),
              ),
            ],
          ],
        ),
      ],
    );
  }
}
