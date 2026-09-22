import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:plantpal/core/theme/app_colors.dart';
import 'package:plantpal/core/theme/app_text_styles.dart';
import 'package:plantpal/core/utils/formatters.dart';
import 'package:plantpal/core/widgets/app_button.dart';
import 'package:plantpal/core/widgets/app_card.dart';
import 'package:plantpal/core/widgets/app_screen.dart';
import 'package:plantpal/core/widgets/app_text_field.dart';
import 'package:plantpal/core/widgets/price_summary.dart';
import 'package:plantpal/core/widgets/state_views.dart';
import 'package:plantpal/features/cart/presentation/controllers/cart_controller.dart';
import 'package:plantpal/features/checkout/domain/entities/checkout_models.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});
  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
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

  void _continue(OrderSummary s) {
    final err = ShippingInfo(name: _name.text, phone: _phone.text, address: _address.text).validate();
    if (err != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(err)));
      return;
    }
    context.push(Uri(path: '/payment', queryParameters: {
      'total': s.total.toStringAsFixed(2),
      'eta': _delivery.eta,
    }).toString());
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartController>();
    if (cart.isEmpty) {
      return AppScreen(
        title: 'Checkout',
        child: EmptyView(icon: Icons.shopping_cart_outlined, title: 'Your cart is empty', actionLabel: 'Continue Shopping', onAction: () => context.go('/shop')),
      );
    }
    final s = const CalculateOrderSummary()(cart.subtotal, _delivery);

    return AppScreen(
      title: 'Checkout',
      child: ListView(padding: const EdgeInsets.only(bottom: 32), children: [
        const SectionTitle('Shipping Information'),
        AppTextField(controller: _name, hint: 'Full Name', icon: Icons.person_outline),
        const SizedBox(height: 12),
        AppTextField(controller: _phone, hint: 'Phone Number', icon: Icons.phone_outlined, keyboardType: TextInputType.phone),
        const SizedBox(height: 12),
        AppTextField(controller: _address, hint: 'Shipping Address', icon: Icons.location_on_outlined, maxLines: 3),
        const SectionTitle('Delivery Method'),
        for (final d in DeliveryOption.all)
          AppCard(
            margin: const EdgeInsets.only(bottom: 10),
            color: _delivery == d ? AppColors.surfaceGreen : Colors.white,
            onTap: () => setState(() => _delivery = d),
            child: Row(children: [
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(d.title, style: AppTextStyles.inter(15, w: FontWeight.w700)),
                  Text('${d.eta} • ${taka(d.fee)}', style: AppTextStyles.inter(13, c: AppColors.textMuted)),
                ]),
              ),
              if (_delivery == d) const Icon(Icons.check_circle, color: AppColors.greenPrimary),
            ]),
          ),
        const SectionTitle('Order Summary'),
        PriceSummary(subtotal: s.subtotal, shipping: s.shipping, tax: s.tax),
        const SizedBox(height: 16),
        SizedBox(width: double.infinity, child: AppButton(label: 'Continue to Payment', onPressed: () => _continue(s))),
      ]),
    );
  }
}