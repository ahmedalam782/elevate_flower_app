import '../../../../core/config/base_response/result.dart';
import '../models/user_addresses_response.dart';

abstract class DeliveryAddressDataSourceContract {
  Future<Result<UserAddressesResponse>> getUserAddresses();
}
