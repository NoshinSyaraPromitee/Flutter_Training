class DeliveryOption {
  const DeliveryOption(this.id, this.title, this.eta, this.fee);
  final String id, title, eta;
  final double fee;

  // One source of truth for both the label and the charged amount. Adjust fees here.
  static const standard = DeliveryOption('standard', 'Standard Delivery', '3-5 Days', 60);
  static const express = DeliveryOption('express', 'Express Delivery', '1-2 Days', 120);
  static const all = [standard, express];
}

class OrderSummary {
  const OrderSummary({required this.subtotal, required this.shipping, required this.tax});
  final double subtotal, shipping, tax;
  double get total => subtotal + shipping + tax;
}

class CalculateOrderSummary {
  const CalculateOrderSummary();
  static const taxRate = 0.05;

  OrderSummary call(double subtotal, DeliveryOption delivery) =>
      OrderSummary(subtotal: subtotal, shipping: subtotal > 0 ? delivery.fee : 0, tax: subtotal * taxRate);
}

class ShippingInfo {
  const ShippingInfo({required this.name, required this.phone, required this.address});
  final String name, phone, address;

  String? validate() {
    if (name.trim().isEmpty) return 'Please enter your full name.';
    if (phone.trim().length < 7) return 'Please enter a valid phone number.';
    if (address.trim().isEmpty) return 'Please enter your shipping address.';
    return null;
  }
}