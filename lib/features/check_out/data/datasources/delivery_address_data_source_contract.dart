import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/check_out/data/models/user_addresses_response.dart';

abstract class DeliveryAddressDataSourceContract {
  Future<Result<UserAddressesResponse>> getUserAddresses();
}
