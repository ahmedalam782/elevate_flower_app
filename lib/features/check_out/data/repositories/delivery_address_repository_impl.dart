import '../../../../core/config/base_response/result.dart';
import '../datasources/delivery_address_data_source_contract.dart';
import '../models/user_addresses_response.dart';
import '../../domain/entities/address_entity.dart';
import '../../domain/repositories/delivery_address_repository.dart';
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
