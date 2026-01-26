// TODO: data Address_detailsLocalDataSourceContract

import 'package:elevate_flower_app/features/address_details/data/models/cities_model.dart';
import 'package:elevate_flower_app/features/address_details/data/models/states_model.dart';

abstract class AddressDetailsLocalDataSourceContract {
  Future<List<StatesModel>> getAllStates();
  Future<List<CityModel>> getAllCitites();
}
