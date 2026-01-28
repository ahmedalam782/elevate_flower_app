import 'package:elevate_flower_app/features/check_out/data/models/shipping_address_model.dart';
import 'package:elevate_flower_app/features/check_out/domain/repositories/payment_repository.dart';

sealed class CheckOutEvents {}
class CheckOutEvent extends CheckOutEvents {
  final ShippingAddressModel address;
  CheckOutEvent({required this.address});
}
class SelectPaymentMethodEvent extends CheckOutEvents {
  final PaymentStrategy paymentMethodType;
  SelectPaymentMethodEvent({required this.paymentMethodType});
}