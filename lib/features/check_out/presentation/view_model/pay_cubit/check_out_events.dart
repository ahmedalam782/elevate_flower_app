import 'package:elevate_flower_app/features/check_out/domain/entities/address_entity.dart';
import 'package:elevate_flower_app/features/check_out/domain/repositories/payment_repository.dart';

sealed class CheckOutEvents {}
class CheckOutEvent extends CheckOutEvents {
  CheckOutEvent();
}
class SelectPaymentMethodEvent extends CheckOutEvents {
  final PaymentStrategy paymentMethodType;
  SelectPaymentMethodEvent({required this.paymentMethodType});
}
class GetUserAddressesEvent extends CheckOutEvents {}
class SelectAddressEvent extends CheckOutEvents {
  final AddressEntity address;
  SelectAddressEvent({required this.address});
}