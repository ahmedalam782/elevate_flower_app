import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/user_addresses/data/models/get_all_addresses_response.dart';
import 'package:elevate_flower_app/features/user_addresses/data/models/remove_address_response.dart';

abstract class UserAddressesRemoteDataSourceContract {
  Future<Result<GetAllAddressesResponse>> getAllAddresses();
  Future<Result<RemoveAddressResponse>> removeAddress(String id);
}
