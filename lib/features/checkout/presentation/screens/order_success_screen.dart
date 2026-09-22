import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_card.dart';

class OrderSuccessScreen extends StatelessWidget {
  const OrderSuccessScreen({
    super.key,
    required this.orderId,
    required this.eta,
  });

  final String orderId;
  final String eta;

  Widget _row(String label, String value, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTextStyles.bodyText.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          Text(
            value,
            style: AppTextStyles.bodyText.copyWith(
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.green,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.lg),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check,
                  size: 64,
                  color: AppColors.green,
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              Text(
                'Order Confirmed!',
                style: AppTextStyles.displayLarge.copyWith(fontSize: 28),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'Thank you for shopping with MyPlantPal.\nYour order has been placed successfully.',
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyText.copyWith(
                  color: Colors.white.withValues(alpha: 0.9),
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              AppCard(
                child: Column(
                  children: [
                    _row('Order ID', '#$orderId'),
                    const Divider(),
                    _row('Estimated Delivery', eta),
                    const Divider(),
                    _row('Status', 'Processing', color: AppColors.green),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              AppButton(
                label: 'Back to Home',
                variant: AppButtonVariant.secondary,
                trailingIcon: Icons.home,
                expand: true,
                onPressed: () => context.go('/home'),
              ),
              const SizedBox(height: AppSpacing.sm),
              AppButton(
                label: 'Continue Shopping',
                trailingIcon: Icons.shopping_bag_outlined,
                expand: true,
                onPressed: () => context.go('/shop'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
