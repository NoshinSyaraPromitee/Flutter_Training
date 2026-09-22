import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/quantity_stepper.dart';

/// Quantity stepper + Add to Cart / Buy Now buttons on the product
/// details screen.
class ProductActions extends StatelessWidget {
  const ProductActions({
    super.key,
    required this.quantity,
    required this.onMinus,
    required this.onPlus,
    required this.onAddToCart,
    required this.onBuyNow,
  });

  final int quantity;
  final VoidCallback onMinus;
  final VoidCallback onPlus;
  final VoidCallback onAddToCart;
  final VoidCallback onBuyNow;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        QuantityStepper(value: quantity, onMinus: onMinus, onPlus: onPlus),
        const SizedBox(height: AppSpacing.lg),
        AppButton(
          label: 'Add to Cart',
          trailingIcon: Icons.add_shopping_cart,
          expand: true,
          onPressed: onAddToCart,
        ),
        const SizedBox(height: AppSpacing.sm),
        AppButton(
          label: 'Buy Now',
          variant: AppButtonVariant.secondary,
          expand: true,
          onPressed: onBuyNow,
        ),
      ],
    );
  }
}
