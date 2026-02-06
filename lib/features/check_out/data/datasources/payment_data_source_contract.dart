import '../../../../core/config/base_response/result.dart';
import '../models/cash_payment_response.dart';
import '../models/credit_payment_response.dart';
import '../models/shipping_address_model.dart';

abstract class PaymentDataSourceContract {
  Future<Result<CashPaymentResponse>> payWithCash({required ShippingAddressModel address});

  Future<Result<CreditPaymentResponse>> payWithCredit({required ShippingAddressModel address});

}