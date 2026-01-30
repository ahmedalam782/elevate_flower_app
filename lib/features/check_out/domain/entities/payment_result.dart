import 'package:equatable/equatable.dart';

sealed class PaymentResult extends Equatable {
  const PaymentResult();
}

class PaymentSuccess extends Equatable implements PaymentResult {
  final String orderNum;
  const PaymentSuccess({required this.orderNum});

  @override
  List<Object?> get props => [orderNum];
}

class PaymentRedirect extends Equatable implements PaymentResult {
  final String paymentUrl;
  const PaymentRedirect({required this.paymentUrl});

  @override
  List<Object?> get props => [paymentUrl];
}
