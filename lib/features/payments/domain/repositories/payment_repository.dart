import 'package:plantpal/features/payments/domain/entities/payment_models.dart';

abstract class PaymentRepository {
  Future<PaymentResult> pay({required double total, required PaymentMethod method});
}