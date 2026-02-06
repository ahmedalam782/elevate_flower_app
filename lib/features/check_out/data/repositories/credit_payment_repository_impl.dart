import '../../../../core/config/base_response/result.dart';
import '../datasources/payment_data_source_contract.dart';
import '../models/shipping_address_model.dart';
import '../../domain/entities/payment_result.dart';
import '../../domain/repositories/payment_repository.dart';
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
