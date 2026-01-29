import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/user_addresses/domain/entities/user_address_entity.dart';

abstract class UserAddressesRepository {
  Future<Result<List<UserAddressEntity>>> getAllAddresses();
  Future<Result<List<UserAddressEntity>>> deleteAddress(String id);
}
