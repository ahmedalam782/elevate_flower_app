// TODO: data Address_detailsRemoteDataSourceContract

import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/address_details/data/models/address_details_data.dart';

abstract class AddressDetailsRemoteDataSourceContract {
  Future<Result<void>> addAddressDetails(AddressDetailsData data);
  Future<Result<void>> updateAddress(AddressDetailsData data, String id);
}
