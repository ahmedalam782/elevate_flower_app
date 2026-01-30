import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/core/config/di/injectable_config.dart';
import 'package:elevate_flower_app/features/check_out/data/models/shipping_address_model.dart';
import 'package:elevate_flower_app/features/check_out/domain/entities/payment_result.dart';

enum PaymentStrategy { cash, credit }

extension MapToPaymentStrategy on PaymentStrategy {
  PaymentRepository getPaymentRepository() {
    switch (this) {
      case PaymentStrategy.cash:
        return getIt<PaymentRepository>(instanceName: 'Cash');
      case PaymentStrategy.credit:
        return getIt<PaymentRepository>(instanceName: 'Credit');
    }
  }
}

abstract class PaymentRepository {
  PaymentStrategy get paymentMethodType;
  Future<Result<PaymentResult>> perform({
    required ShippingAddressModel address,
  });
}
