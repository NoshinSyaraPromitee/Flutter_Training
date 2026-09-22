import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:plantpal/core/theme/app_colors.dart';
import 'package:plantpal/core/theme/app_text_styles.dart';
import 'package:plantpal/core/utils/formatters.dart';
import 'package:plantpal/core/widgets/app_button.dart';
import 'package:plantpal/core/widgets/app_card.dart';
import 'package:plantpal/core/widgets/app_screen.dart';
import 'package:plantpal/core/widgets/net_image.dart';
import 'package:plantpal/core/widgets/price_summary.dart';
import 'package:plantpal/core/widgets/quantity_stepper.dart';
import 'package:plantpal/core/widgets/state_views.dart';
import 'package:plantpal/features/cart/presentation/controllers/cart_controller.dart';
import 'package:plantpal/features/checkout/domain/entities/checkout_models.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartController>();
    if (cart.isEmpty) {
      return AppScreen(
        title: 'My Cart',
        child: EmptyView(
          icon: Icons.shopping_cart_outlined,
          title: 'Your cart is empty',
          actionLabel: 'Continue Shopping',
          onAction: () => context.go('/shop'),
        ),
      );
    }
    final s = const CalculateOrderSummary()(cart.subtotal, DeliveryOption.standard);

    return AppScreen(
      title: 'My Cart',
      child: Column(children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            itemCount: cart.items.length,
            itemBuilder: (_, i) {
              final item = cart.items[i];
              final p = item.product;
              return AppCard(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(12),
                child: Row(children: [
                  NetImage(p.imageUrl, width: 80, height: 80),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(p.name, maxLines: 2, overflow: TextOverflow.ellipsis, style: AppTextStyles.inter(15, w: FontWeight.w700)),
                      Text(p.unit == null ? p.category : '${p.category} • ${p.unit}', style: AppTextStyles.inter(12, c: AppColors.textMuted)),
                      Text(taka(p.price), style: AppTextStyles.inter(15, w: FontWeight.w800, c: const Color(0xFFFF9800))),
                      const SizedBox(height: 6),
                      QuantityStepper(
                        value: item.quantity,
                        onMinus: () => cart.decrease(p.id),
                        onPlus: () => cart.increase(p.id),
                      ),
                    ]),
                  ),
                  IconButton(icon: const Icon(Icons.delete_outline, color: AppColors.danger, size: 26), onPressed: () => cart.remove(p.id)),
                ]),
              );
            },
          ),
        ),
        PriceSummary(subtotal: s.subtotal, shipping: s.shipping, tax: s.tax),
        const SizedBox(height: 12),
        SizedBox(width: double.infinity, child: AppButton(label: 'Proceed to Checkout', onPressed: () => context.push('/checkout'))),
        const SizedBox(height: 16),
      ]),
    );
  }
}