import 'package:elevate_flower_app/features/address_details/data/models/cities_model.dart';
import 'package:elevate_flower_app/features/address_details/data/models/states_model.dart';

abstract class AddressDetailsRepository {
  Future<List<StatesModel>> getStates();
  Future<List<CityModel>> getAllCities();
}
