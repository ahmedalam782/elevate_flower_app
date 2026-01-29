import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/address_details/data/models/address_details_data.dart';
import 'package:elevate_flower_app/features/address_details/data/models/cities_model.dart';
import 'package:elevate_flower_app/features/address_details/data/models/states_model.dart';

abstract class AddressDetailsRepository {
  Future<List<StatesModel>> getStates();
  Future<List<CityModel>> getAllCities();
  Future<Result<void>> addAddressDetails(AddressDetailsData data);
  Future<Result<void>> updateAddress(AddressDetailsData data, String id);
}
