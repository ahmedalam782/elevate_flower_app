import '../../../../core/config/api/api_executer.dart';
import '../../../../core/config/base_response/result.dart';
import '../api_client/user_addresses_api_client.dart';
import '../../data/datasources/user_addresses_remote_data_source_contract.dart';
import '../../data/models/get_all_addresses_response.dart';
import '../../data/models/remove_address_response.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: UserAddressesRemoteDataSourceContract)
class UserAddressesRemoteDataSourceImpl
    implements UserAddressesRemoteDataSourceContract {
  final UserAddressesApiClient _userAddressesApiClient;
  UserAddressesRemoteDataSourceImpl(this._userAddressesApiClient);
  @override
  Future<Result<GetAllAddressesResponse>> getAllAddresses() {
    return executeApi<GetAllAddressesResponse>(
      () => _userAddressesApiClient.getAllAddresses(),
    );
  }

  @override
  Future<Result<RemoveAddressResponse>> removeAddress(String id) {
    return executeApi<RemoveAddressResponse>(
      () => _userAddressesApiClient.deleteAddress(id),
    );
  }
}
