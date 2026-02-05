import '../../../domain/entities/address_entity.dart';
import '../../../domain/repositories/payment_repository.dart';

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