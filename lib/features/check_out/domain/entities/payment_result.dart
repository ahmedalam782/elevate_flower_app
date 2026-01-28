sealed class PaymentResult {
  const PaymentResult();
}

class PaymentSuccess extends PaymentResult {
  final String orderNum;
  const PaymentSuccess({ required this.orderNum});
}
class PaymentRedirect extends PaymentResult {
  final String paymentUrl;
  const PaymentRedirect({ required this.paymentUrl});
}