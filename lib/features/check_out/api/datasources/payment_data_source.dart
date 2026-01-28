import 'package:elevate_flower_app/core/config/api/api_executer.dart';
import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/check_out/api/api_client/pay/payment_api_client.dart';
import 'package:elevate_flower_app/features/check_out/data/datasources/payment_data_source_contract.dart';
import 'package:elevate_flower_app/features/check_out/data/models/cash_payment_response.dart';
import 'package:elevate_flower_app/features/check_out/data/models/credit_payment_response.dart';
import 'package:elevate_flower_app/features/check_out/data/models/shipping_address_model.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: PaymentDataSourceContract)
class PaymentDataSource implements PaymentDataSourceContract {
  final PaymentApiClient _apiClient;
  PaymentDataSource(this._apiClient);
  @override
  Future<Result<CashPaymentResponse>> payWithCash({
    required ShippingAddressModel address,
  }) async {
    return await executeApi(() async => await _apiClient.payWithCash(address));
  }

  @override
  Future<Result<CreditPaymentResponse>> payWithCredit({
    required ShippingAddressModel address,
  }) async {
    return await executeApi(
      () async => await _apiClient.payWithCredit(address),
    );
  }
}
