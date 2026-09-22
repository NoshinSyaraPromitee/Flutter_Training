import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/curved_header.dart';
import '../../../../core/widgets/net_image.dart';
import '../../../../core/widgets/price_summary.dart';
import '../../../../core/widgets/quantity_stepper.dart';
import '../../../../core/widgets/state_views.dart';
import '../providers/cart_providers.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(cartProvider);
    final subtotal = ref.watch(cartSubtotalProvider);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CurvedHeader(
            title: 'My Cart',
            color: AppColors.orange,
            onBack: () => context.pop(),
          ),
          Expanded(
            child: items.isEmpty
                ? EmptyView(
                    icon: Icons.shopping_cart_outlined,
                    title: 'Your cart is empty',
                    actionLabel: 'Continue Shopping',
                    onAction: () => context.go('/shop'),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.all(AppSpacing.xl),
                    itemCount: items.length,
                    separatorBuilder: (_, _) =>
                        const SizedBox(height: AppSpacing.md),
                    itemBuilder: (context, index) {
                      final item = items[index];
                      final product = item.product;
                      return AppCard(
                        child: Row(
                          children: [
                            NetImage(
                              product.imageUrl,
                              width: 72,
                              height: 72,
                              radius: AppRadius.sm,
                            ),
                            const SizedBox(width: AppSpacing.md),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.name,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTextStyles.titleMedium.copyWith(
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    taka(product.price),
                                    style: AppTextStyles.bodyText.copyWith(
                                      color: AppColors.orange,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(height: AppSpacing.xs),
                                  QuantityStepper(
                                    value: item.quantity,
                                    onMinus: () => ref
                                        .read(cartProvider.notifier)
                                        .decrease(product.id),
                                    onPlus: () => ref
                                        .read(cartProvider.notifier)
                                        .increase(product.id),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.delete_outline,
                                color: AppColors.danger,
                              ),
                              onPressed: () => ref
                                  .read(cartProvider.notifier)
                                  .remove(product.id),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
          if (items.isNotEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.xl,
                0,
                AppSpacing.xl,
                AppSpacing.xl,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  PriceSummary(
                    subtotal: subtotal,
                    shipping: subtotal > 0 ? 60 : 0,
                    tax: subtotal * 0.05,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  AppButton(
                    label: 'Proceed to Checkout',
                    expand: true,
                    onPressed: () => context.push('/checkout'),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
