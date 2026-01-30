import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/user_addresses/data/datasources/user_addresses_remote_data_source_contract.dart';
import 'package:elevate_flower_app/features/user_addresses/domain/entities/user_address_entity.dart';
import 'package:elevate_flower_app/features/user_addresses/domain/repositories/user_addresses_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: UserAddressesRepository)
class UserAddressesRepositoryImpl implements UserAddressesRepository {
  final UserAddressesRemoteDataSourceContract _remoteDataSource;
  UserAddressesRepositoryImpl(this._remoteDataSource);

  @override
  Future<Result<List<UserAddressEntity>>> deleteAddress(String id) async {
    final result = await _remoteDataSource.removeAddress(id);
    return result.when(
      success: (data) {
        final addresses = data?.address?.map((e) => e.toEntity()).toList();
        return Success(data: addresses);
      },
      error: (error) {
        return Error(exception: error);
      },
    );
  }

  @override
  Future<Result<List<UserAddressEntity>>> getAllAddresses() async {
    final result = await _remoteDataSource.getAllAddresses();
    return result.when(
      success: (data) {
        final addresses = data?.addresses?.map((e) => e.toEntity()).toList();
        return Success(data: addresses);
      },
      error: (error) {
        return Error(exception: error);
      },
    );
  }
}
