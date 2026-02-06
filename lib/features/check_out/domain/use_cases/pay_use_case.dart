import '../../../../core/config/base_response/result.dart';
import '../../data/models/shipping_address_model.dart';
import '../entities/payment_result.dart';
import '../repositories/payment_repository.dart';
import 'package:injectable/injectable.dart';
@lazySingleton
class PayUseCase {
  Future<Result<PaymentResult>> call({
    required PaymentRepository paymentRepository,
    required ShippingAddressModel address,
  }) {
    return paymentRepository.perform(address: address);
  }
}