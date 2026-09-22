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
import '../../../cart/presentation/providers/cart_providers.dart';
import '../../domain/payment_method.dart';
import '../widgets/payment_method_tile.dart';
import '../widgets/secure_checkout_banner.dart';

/// Simulated payment — there's no payment provider integration yet (see
/// CLAUDE.md: payment verification must be handled securely server-side
/// once a real one exists). This always "succeeds" after a short delay.
class PaymentScreen extends ConsumerStatefulWidget {
  const PaymentScreen({super.key, required this.total, required this.eta});

  final double total;
  final String eta;

  @override
  ConsumerState<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends ConsumerState<PaymentScreen> {
  PaymentMethod _method = PaymentMethod.all.first;
  bool _processing = false;

  Future<void> _pay() async {
    setState(() => _processing = true);
    await Future<void>.delayed(const Duration(seconds: 1));
    if (!mounted) return;

    final orderId = DateTime.now().millisecondsSinceEpoch.toString().substring(
      5,
    );
    ref.read(cartProvider.notifier).clear();
    context.go(
      Uri(
        path: '/order-success',
        queryParameters: {'orderId': orderId, 'eta': widget.eta},
      ).toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CurvedHeader(
            title: 'Payment',
            color: AppColors.green,
            onBack: () => context.pop(),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(AppSpacing.xl),
              children: [
                const SecureCheckoutBanner(),
                const SizedBox(height: AppSpacing.lg),
                Text('Select Payment Method', style: AppTextStyles.titleLarge),
                const SizedBox(height: AppSpacing.sm),
                for (final method in PaymentMethod.all) ...[
                  PaymentMethodTile(
                    method: method,
                    selected: _method.id == method.id,
                    onTap: () => setState(() => _method = method),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                ],
                const SizedBox(height: AppSpacing.sm),
                AppCard(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Order Total',
                        style: AppTextStyles.bodyText.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        taka(widget.total),
                        style: AppTextStyles.displayMedium.copyWith(
                          fontSize: 20,
                          color: AppColors.green,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                AppButton(
                  label: _processing
                      ? 'Processing...'
                      : 'Pay ${taka(widget.total)}',
                  leadingIcon: _processing ? null : Icons.lock,
                  isLoading: _processing,
                  expand: true,
                  onPressed: _processing ? null : _pay,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
