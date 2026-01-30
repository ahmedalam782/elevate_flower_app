import 'package:elevate_flower_app/core/config/api/api_executer.dart';
import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/check_out/api/api_client/user_addresses/user_addresses_api_client.dart';
import 'package:elevate_flower_app/features/check_out/data/datasources/delivery_address_data_source_contract.dart';
import 'package:elevate_flower_app/features/check_out/data/models/user_addresses_response.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: DeliveryAddressDataSourceContract)
class DeliveryAddressDataSource implements DeliveryAddressDataSourceContract {
  final UserAddressesApiClient _apiClient;
  DeliveryAddressDataSource(this._apiClient);
  @override
  Future<Result<UserAddressesResponse>> getUserAddresses() async {
    return await executeApi(() async => await _apiClient.getUserAddresses());
  }
}
