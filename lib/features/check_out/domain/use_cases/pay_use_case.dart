import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/check_out/data/models/shipping_address_model.dart';
import 'package:elevate_flower_app/features/check_out/domain/entities/payment_result.dart';
import 'package:elevate_flower_app/features/check_out/domain/repositories/payment_repository.dart';
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