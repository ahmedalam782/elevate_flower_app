import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/check_out/domain/entities/address_entity.dart';

abstract class DeliveryAddressRepository {
  Future<Result<List<AddressEntity>>> getUserAddresses();
}