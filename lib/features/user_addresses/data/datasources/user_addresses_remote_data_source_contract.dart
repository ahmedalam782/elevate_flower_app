import '../../../../core/config/base_response/result.dart';
import '../models/get_all_addresses_response.dart';
import '../models/remove_address_response.dart';

abstract class UserAddressesRemoteDataSourceContract {
  Future<Result<GetAllAddressesResponse>> getAllAddresses();
  Future<Result<RemoveAddressResponse>> removeAddress(String id);
}
