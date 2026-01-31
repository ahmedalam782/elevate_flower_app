import '../../../../core/config/base_response/result.dart';
import '../../data/models/address_details_data.dart';
import '../../data/models/cities_model.dart';
import '../../data/models/states_model.dart';

abstract class AddressDetailsRepository {
  Future<List<StatesModel>> getStates();
  Future<List<CityModel>> getAllCities();
  Future<Result<void>> addAddressDetails(AddressDetailsData data);
  Future<Result<void>> updateAddress(AddressDetailsData data, String id);
}
