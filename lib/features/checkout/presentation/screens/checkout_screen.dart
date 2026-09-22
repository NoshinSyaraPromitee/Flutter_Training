import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/curved_header.dart';
import '../../../../core/widgets/price_summary.dart';
import '../../../../core/widgets/state_views.dart';
import '../../../cart/presentation/providers/cart_providers.dart';
import '../../domain/delivery_option.dart';
import '../widgets/delivery_option_tile.dart';
import '../widgets/shipping_form.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key});

  @override
  ConsumerState<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  final _name = TextEditingController();
  final _phone = TextEditingController();
  final _address = TextEditingController();
  DeliveryOption _delivery = DeliveryOption.standard;

  @override
  void dispose() {
    _name.dispose();
    _phone.dispose();
    _address.dispose();
    super.dispose();
  }

  void _continue(OrderSummary summary) {
    if (_name.text.trim().isEmpty ||
        _phone.text.trim().isEmpty ||
        _address.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in your name, phone, and address.'),
        ),
      );
      return;
    }
    context.push(
      Uri(
        path: '/payment',
        queryParameters: {
          'total': summary.total.toStringAsFixed(2),
          'eta': _delivery.eta,
        },
      ).toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final subtotal = ref.watch(cartSubtotalProvider);

    if (subtotal == 0) {
      return Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CurvedHeader(
              title: 'Checkout',
              color: AppColors.orange,
              onBack: () => context.pop(),
            ),
            Expanded(
              child: EmptyView(
                icon: Icons.shopping_cart_outlined,
                title: 'Your cart is empty',
                actionLabel: 'Continue Shopping',
                onAction: () => context.go('/shop'),
              ),
            ),
          ],
        ),
      );
    }

    final summary = calculateOrderSummary(subtotal, _delivery);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CurvedHeader(
            title: 'Checkout',
            color: AppColors.orange,
            onBack: () => context.pop(),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(AppSpacing.xl),
              children: [
                Text('Shipping Information', style: AppTextStyles.titleLarge),
                const SizedBox(height: AppSpacing.sm),
                ShippingForm(name: _name, phone: _phone, address: _address),
                const SizedBox(height: AppSpacing.lg),
                Text('Delivery Method', style: AppTextStyles.titleLarge),
                const SizedBox(height: AppSpacing.sm),
                for (final option in DeliveryOption.all) ...[
                  DeliveryOptionTile(
                    option: option,
                    selected: _delivery.id == option.id,
                    onTap: () => setState(() => _delivery = option),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                ],
                const SizedBox(height: AppSpacing.md),
                Text('Order Summary', style: AppTextStyles.titleLarge),
                const SizedBox(height: AppSpacing.sm),
                PriceSummary(
                  subtotal: summary.subtotal,
                  shipping: summary.shipping,
                  tax: summary.tax,
                ),
                const SizedBox(height: AppSpacing.lg),
                AppButton(
                  label: 'Continue to Payment',
                  expand: true,
                  onPressed: () => _continue(summary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
