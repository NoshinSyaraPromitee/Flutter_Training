import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:plantpal/core/theme/app_colors.dart';
import 'package:plantpal/core/theme/app_text_styles.dart';
import 'package:plantpal/core/utils/formatters.dart';
import 'package:plantpal/core/widgets/app_button.dart';
import 'package:plantpal/core/widgets/app_card.dart';
import 'package:plantpal/core/widgets/app_screen.dart';
import 'package:plantpal/features/cart/presentation/controllers/cart_controller.dart';
import 'package:plantpal/features/payments/domain/model/payment_models.dart';
import 'package:plantpal/features/payments/presentation/controllers/payment_controller.dart';
import 'package:provider/provider.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key, required this.total, required this.eta});
  final double total;
  final String eta;
  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  PaymentMethod _method = PaymentMethod.all.first;

  static const _icons = {
    'card': Icons.credit_card,
    'bkash': Icons.phone_android,
    'nagad': Icons.account_balance_wallet_outlined,
    'cod': Icons.payments_outlined,
  };

  Future<void> _pay() async {
    final result = await context.read<PaymentController>().pay(widget.total, _method);
    if (!mounted) return;

    if (result.success) {
      await showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => AlertDialog(
          icon: const Icon(Icons.check_circle, size: 56, color: AppColors.greenPrimary),
          title: const Text('Payment Successful!'),
          content: Text('Your payment of ${taka(widget.total)} via ${_method.title} was completed. Your order has been placed.'),
          actions: [TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('View Order'))],
        ),
      );
      if (!mounted) return;
      context.read<CartController>().clear();
      context.go(Uri(path: '/order-success', queryParameters: {'orderId': result.orderId, 'eta': widget.eta}).toString());
    } else {
      final changeMethod = await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          icon: const Icon(Icons.cancel, size: 56, color: AppColors.danger),
          title: const Text('Payment Failed'),
          content: const Text('We could not process your payment. Please try again or choose a different payment method.'),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Change Payment Method')),
            TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Try Again')),
          ],
        ),
      );
      if (changeMethod == true && mounted) context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final processing = context.watch<PaymentController>().processing;

    return AppScreen(
      title: 'Payment',
      child: ListView(padding: const EdgeInsets.only(bottom: 32), children: [
        AppCard(
          child: Row(children: [
            const Icon(Icons.verified_user, size: 40, color: AppColors.greenPrimary),
            const SizedBox(width: 14),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Secure Checkout', style: AppTextStyles.inter(15, w: FontWeight.w700, c: AppColors.greenPrimary)),
                Text('Your payment information is encrypted and secure.', style: AppTextStyles.inter(12, c: AppColors.textMuted)),
              ]),
            ),
          ]),
        ),
        const SectionTitle('Select Payment Method'),
        for (final m in PaymentMethod.all)
          AppCard(
            margin: const EdgeInsets.only(bottom: 10),
            color: _method == m ? AppColors.surfaceGreen : Colors.white,
            onTap: () => setState(() => _method = m),
            child: Row(children: [
              Icon(_icons[m.id], size: 28, color: _method == m ? AppColors.greenPrimary : Colors.black54),
              const SizedBox(width: 14),
              Expanded(child: Text(m.title, style: AppTextStyles.inter(15, w: FontWeight.w600))),
              if (_method == m) const Icon(Icons.check_circle, color: AppColors.greenPrimary),
            ]),
          ),
        const SizedBox(height: 8),
        AppCard(
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('Order Total', style: AppTextStyles.inter(15, w: FontWeight.w600)),
            Text(taka(widget.total), style: AppTextStyles.inter(20, w: FontWeight.w800, c: AppColors.greenPrimary)),
          ]),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: AppButton(
            label: processing ? 'Processing...' : 'Pay ${taka(widget.total)}',
            trailingIcon: processing ? null : Icons.lock,
            onPressed: processing ? null : _pay,
          ),
        ),
      ]),
    );
  }
}