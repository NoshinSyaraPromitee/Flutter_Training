class DeliveryOption {
  const DeliveryOption({
    required this.id,
    required this.title,
    required this.eta,
    required this.fee,
  });

  final String id;
  final String title;
  final String eta;
  final double fee;

  static const standard = DeliveryOption(
    id: 'standard',
    title: 'Standard Delivery',
    eta: '3-5 Days',
    fee: 60,
  );
  static const express = DeliveryOption(
    id: 'express',
    title: 'Express Delivery',
    eta: '1-2 Days',
    fee: 150,
  );

  static const all = [standard, express];
}

class OrderSummary {
  const OrderSummary({
    required this.subtotal,
    required this.shipping,
    required this.tax,
  });

  final double subtotal;
  final double shipping;
  final double tax;

  double get total => subtotal + shipping + tax;
}

OrderSummary calculateOrderSummary(double subtotal, DeliveryOption delivery) {
  return OrderSummary(
    subtotal: subtotal,
    shipping: subtotal > 0 ? delivery.fee : 0,
    tax: subtotal * 0.05,
  );
}
