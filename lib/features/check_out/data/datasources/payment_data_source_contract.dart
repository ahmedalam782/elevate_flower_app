import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/check_out/data/models/cash_payment_response.dart';
import 'package:elevate_flower_app/features/check_out/data/models/credit_payment_response.dart';
import 'package:elevate_flower_app/features/check_out/data/models/shipping_address_model.dart';

abstract class PaymentDataSourceContract {
  Future<Result<CashPaymentResponse>> payWithCash({required ShippingAddressModel address});

  Future<Result<CreditPaymentResponse>> payWithCredit({required ShippingAddressModel address});

}