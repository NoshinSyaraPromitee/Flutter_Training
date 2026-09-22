class PaymentMethod {
  const PaymentMethod(this.id, this.title);
  final String id, title;

  static const all = [
    PaymentMethod('card', 'Credit / Debit Card'),
    PaymentMethod('bkash', 'bKash'),
    PaymentMethod('nagad', 'Nagad'),
    PaymentMethod('cod', 'Cash on Delivery'),
  ];
}

class PaymentResult {
  const PaymentResult({required this.success, this.orderId = ''});
  final bool success;
  final String orderId;
}