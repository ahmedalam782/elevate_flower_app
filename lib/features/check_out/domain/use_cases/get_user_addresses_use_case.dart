import '../../../../core/config/base_response/result.dart';
import '../entities/address_entity.dart';
import '../repositories/delivery_address_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetUserAddressesUseCase {
  final DeliveryAddressRepository _repository;
  GetUserAddressesUseCase(this._repository);
  Future<Result<List<AddressEntity>>> call() async {
    return await _repository.getUserAddresses();
  }
}
