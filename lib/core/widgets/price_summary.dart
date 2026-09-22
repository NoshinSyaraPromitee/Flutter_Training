import 'package:flutter/material.dart';
import 'package:plantpal/core/theme/app_text_styles.dart';
import 'package:plantpal/core/utils/formatters.dart';
import 'package:plantpal/core/widgets/app_card.dart';

class PriceSummary extends StatelessWidget {
  const PriceSummary({super.key, required this.subtotal, required this.shipping, required this.tax});
  final double subtotal, shipping, tax;

  @override
  Widget build(BuildContext context) {
    Widget row(String l, double v, {bool bold = false}) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(l, style: AppTextStyles.inter(bold ? 17 : 14, w: bold ? FontWeight.w700 : FontWeight.w500)),
            Text(taka(v), style: AppTextStyles.inter(bold ? 17 : 14, w: bold ? FontWeight.w700 : FontWeight.w500)),
          ]),
        );
    return AppCard(
      child: Column(children: [
        row('Subtotal', subtotal),
        row('Shipping', shipping),
        row('Tax (5%)', tax),
        const Divider(),
        row('Total', subtotal + shipping + tax, bold: true),
      ]),
    );
  }
}