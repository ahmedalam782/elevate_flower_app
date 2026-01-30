import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/check_out/data/datasources/payment_data_source_contract.dart';
import 'package:elevate_flower_app/features/check_out/data/models/shipping_address_model.dart';
import 'package:elevate_flower_app/features/check_out/domain/entities/payment_result.dart';
import 'package:elevate_flower_app/features/check_out/domain/repositories/payment_repository.dart';
import 'package:injectable/injectable.dart';

@Named('Credit')
@LazySingleton(as: PaymentRepository)
class CreditPaymentRepositoryImpl implements PaymentRepository {
  final PaymentDataSourceContract _dataSource;

  CreditPaymentRepositoryImpl(this._dataSource);
  @override
  Future<Result<PaymentResult>> perform({
    required ShippingAddressModel address,
  }) async {
    return await _dataSource.payWithCredit(address: address).then((result) {
      return result.when(
        success: (data) => Success(
          data: PaymentRedirect(paymentUrl: data?.session?.url ?? ''),
        ),
        error: (error) => Error(exception: error),
      );
    });
  }

  @override
  PaymentStrategy get paymentMethodType => PaymentStrategy.credit;
}
