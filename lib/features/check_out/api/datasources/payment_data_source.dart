import 'dart:developer';

import '../../../../core/config/api/api_executer.dart';
import '../../../../core/config/base_response/result.dart';
import '../api_client/pay/payment_api_client.dart';
import '../../data/datasources/payment_data_source_contract.dart';
import '../../data/models/cash_payment_response.dart';
import '../../data/models/credit_payment_response.dart';
import '../../data/models/shipping_address_model.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: PaymentDataSourceContract)
class PaymentDataSource implements PaymentDataSourceContract {
  final PaymentApiClient _apiClient;
  PaymentDataSource(this._apiClient);
  @override
  Future<Result<CashPaymentResponse>> payWithCash({
    required ShippingAddressModel address,
  }) async {
    log('Initiating cash payment with address: $address');
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
