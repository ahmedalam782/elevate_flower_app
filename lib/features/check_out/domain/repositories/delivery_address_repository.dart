import '../../../../core/config/base_response/result.dart';
import '../entities/address_entity.dart';

abstract class DeliveryAddressRepository {
  Future<Result<List<AddressEntity>>> getUserAddresses();
}