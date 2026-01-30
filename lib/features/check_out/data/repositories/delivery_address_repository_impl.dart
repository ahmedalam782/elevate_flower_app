import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/check_out/data/datasources/delivery_address_data_source_contract.dart';
import 'package:elevate_flower_app/features/check_out/data/models/user_addresses_response.dart';
import 'package:elevate_flower_app/features/check_out/domain/entities/address_entity.dart';
import 'package:elevate_flower_app/features/check_out/domain/repositories/delivery_address_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: DeliveryAddressRepository)
class DeliveryAddressRepositoryImpl implements DeliveryAddressRepository {
  final DeliveryAddressDataSourceContract _dataSource;
  DeliveryAddressRepositoryImpl(this._dataSource);
  @override
  Future<Result<List<AddressEntity>>> getUserAddresses() async {
    return await _dataSource.getUserAddresses().then((result) {
      return result.when(
        success: (data) {
          
          return Success(
            data: (data?.addresses ?? []).map((e) => e.toEntity()).toList(),
          );
        },
        error: (error) {
          return Error(exception: error);
        },
      );
    });
  }
}
