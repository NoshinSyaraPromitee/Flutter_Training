import 'package:flutter/material.dart';

class PaymentMethod {
  const PaymentMethod(this.id, this.title, this.icon);

  final String id;
  final String title;
  final IconData icon;

  static const all = [
    PaymentMethod('card', 'Credit / Debit Card', Icons.credit_card),
    PaymentMethod('bkash', 'bKash', Icons.phone_android),
    PaymentMethod('nagad', 'Nagad', Icons.account_balance_wallet_outlined),
    PaymentMethod('cod', 'Cash on Delivery', Icons.payments_outlined),
  ];
}
