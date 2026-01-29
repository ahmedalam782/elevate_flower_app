// TODO: data Address_detailsRepositoryImpl

import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/address_details/api/datasources/address_details_local_data_source_impl.dart';
import 'package:elevate_flower_app/features/address_details/data/datasources/address_details_local_data_source_contract.dart';
import 'package:elevate_flower_app/features/address_details/data/datasources/address_details_remote_data_source_contract.dart';
import 'package:elevate_flower_app/features/address_details/data/models/address_details_data.dart';
import 'package:elevate_flower_app/features/address_details/data/models/cities_model.dart';
import 'package:elevate_flower_app/features/address_details/data/models/states_model.dart';
import 'package:elevate_flower_app/features/address_details/domain/repositories/address_details_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AddressDetailsRepository)
class AddressDetailsRepositoryImpl implements AddressDetailsRepository {
  final AddressDetailsLocalDataSourceContract addressDetailsLocalDataSource;
  final AddressDetailsRemoteDataSourceContract addressDetailsRemoteDataSource;

  AddressDetailsRepositoryImpl({
    required this.addressDetailsLocalDataSource,
    required this.addressDetailsRemoteDataSource,
  });
  @override
  Future<List<StatesModel>> getStates() async {
    return addressDetailsLocalDataSource.getAllStates();
  }

  Future<List<CityModel>> getAllCities() async {
    return addressDetailsLocalDataSource.getAllCitites();
  }

  @override
  Future<Result<void>> addAddressDetails(AddressDetailsData data) async {
    final response = await addressDetailsRemoteDataSource.addAddressDetails(
      data,
    );
    switch (response) {
      case Success<void>():
        return const Success<void>();
      case Error<void>():
        return Error<void>(exception: response.exception);
    }
  }

  @override
  Future<Result<void>> updateAddress(AddressDetailsData data, String id) async {
    final response = await addressDetailsRemoteDataSource.updateAddress(
      data,
      id,
    );
    switch (response) {
      case Success<void>():
        return const Success<void>();
      case Error<void>():
        return Error<void>(exception: response.exception);
    }
  }
}
