import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/check_out/domain/entities/address_entity.dart';
import 'package:elevate_flower_app/features/check_out/domain/repositories/delivery_address_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetUserAddressesUseCase {
  final DeliveryAddressRepository _repository;
  GetUserAddressesUseCase(this._repository);
  Future<Result<List<AddressEntity>>> call() async {
    return await _repository.getUserAddresses();
  }
}
