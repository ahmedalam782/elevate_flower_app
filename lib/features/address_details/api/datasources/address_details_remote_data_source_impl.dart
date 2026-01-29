// TODO: api Address_detailsRemoteDataSourceImpl

import 'package:elevate_flower_app/core/config/api/api_executer.dart';
import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/address_details/api/api_client/address_details_api_client.dart';
import 'package:elevate_flower_app/features/address_details/data/datasources/address_details_local_data_source_contract.dart';
import 'package:elevate_flower_app/features/address_details/data/datasources/address_details_remote_data_source_contract.dart';
import 'package:elevate_flower_app/features/address_details/data/models/address_details_data.dart';
import 'package:elevate_flower_app/features/address_details/data/models/cities_model.dart';
import 'package:elevate_flower_app/features/address_details/data/models/states_model.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AddressDetailsRemoteDataSourceContract)
class AddressDetailsRemoteDataSourceImpl
    implements AddressDetailsRemoteDataSourceContract {
  final AddressDetailsApiClient addressDetailsApiClient;

  AddressDetailsRemoteDataSourceImpl({required this.addressDetailsApiClient});
  @override
  Future<Result<void>> addAddressDetails(AddressDetailsData data) async {
    return await executeApi<void>(() async {
      final response = await addressDetailsApiClient.addAddress(data);
      return response;
    });
  }

  @override
  Future<Result<void>> updateAddress(AddressDetailsData data, String id) async {
    return await executeApi<void>(() async {
      final response = await addressDetailsApiClient.updateAddress(data, id);
      return response;
    });
  }
}
