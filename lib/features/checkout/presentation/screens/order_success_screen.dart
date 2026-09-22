import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:plantpal/core/theme/app_colors.dart';
import 'package:plantpal/core/theme/app_text_styles.dart';
import 'package:plantpal/core/widgets/app_back_button.dart';
import 'package:plantpal/core/widgets/app_button.dart';
import 'package:plantpal/core/widgets/app_card.dart';
import 'package:plantpal/core/widgets/gradient_background.dart';

class OrderSuccessScreen extends StatelessWidget {
  const OrderSuccessScreen({super.key, required this.orderId, required this.eta});
  final String orderId, eta;

  Widget _row(String l, String v, {Color? color}) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(l, style: AppTextStyles.inter(14, c: AppColors.textMuted)),
          Text(v, style: AppTextStyles.inter(14, w: FontWeight.w700, c: color ?? AppColors.textDark)),
        ]),
      );

  @override
  Widget build(BuildContext context) => Scaffold(
        body: GradientBackground(
          child: SafeArea(
            child: Stack(children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const CircleAvatar(radius: 60, backgroundColor: AppColors.greenPrimary, child: Icon(Icons.check, size: 70, color: Colors.white)),
                  const SizedBox(height: 20),
                  Text('Order Confirmed!', style: AppTextStyles.screenTitle),
                  const SizedBox(height: 6),
                  Text('Thank you for shopping with PlantPal.\nYour order has been placed successfully.', textAlign: TextAlign.center, style: AppTextStyles.bodyText),
                  const SizedBox(height: 24),
                  AppCard(
                    child: Column(children: [
                      _row('Order ID', '#$orderId'),
                      const Divider(),
                      _row('Estimated Delivery', eta),
                      const Divider(),
                      _row('Status', 'Processing', color: AppColors.greenPrimary),
                    ]),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(width: double.infinity, child: AppButton(label: 'Back to Home', trailingIcon: Icons.home, onPressed: () => context.go('/home'))),
                  const SizedBox(height: 10),
                  SizedBox(width: double.infinity, child: AppButton(label: 'Continue Shopping', variant: AppButtonVariant.orange, trailingIcon: Icons.shopping_bag_outlined, onPressed: () => context.go('/shop'))),
                ]),
              ),
              const Positioned(top: 4, left: 8, child: AppBackButton(fallback: '/shop')),
            ]),
          ),
        ),
      );
}