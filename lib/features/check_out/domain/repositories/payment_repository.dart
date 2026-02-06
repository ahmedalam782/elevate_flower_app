import '../../../../core/config/base_response/result.dart';
import '../../../../core/config/di/injectable_config.dart';
import '../../data/models/shipping_address_model.dart';
import '../entities/payment_result.dart';

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
