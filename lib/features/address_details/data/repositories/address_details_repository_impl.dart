// TODO: data Address_detailsRepositoryImpl

import 'package:elevate_flower_app/features/address_details/api/datasources/address_details_local_data_source_impl.dart';
import 'package:elevate_flower_app/features/address_details/data/datasources/address_details_local_data_source_contract.dart';
import 'package:elevate_flower_app/features/address_details/data/models/cities_model.dart';
import 'package:elevate_flower_app/features/address_details/data/models/states_model.dart';
import 'package:elevate_flower_app/features/address_details/domain/repositories/address_details_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AddressDetailsRepository)
class AddressDetailsRepositoryImpl implements AddressDetailsRepository {
  final AddressDetailsLocalDataSourceContract addressDetailsLocalDataSource;

  AddressDetailsRepositoryImpl({required this.addressDetailsLocalDataSource});
  @override
  Future<List<StatesModel>> getStates() async {
    return addressDetailsLocalDataSource.getAllStates();
  }

  Future<List<CityModel>> getAllCities() async {
    return addressDetailsLocalDataSource.getAllCitites();
  }
}
