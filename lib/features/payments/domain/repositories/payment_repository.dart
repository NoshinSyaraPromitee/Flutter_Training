import 'package:plantpal/features/payments/domain/model/payment_models.dart';

abstract class PaymentRepository {
  Future<PaymentResult> pay({required double total, required PaymentMethod method});
}