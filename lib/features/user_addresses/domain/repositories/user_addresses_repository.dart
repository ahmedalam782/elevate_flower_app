import '../../../../core/config/base_response/result.dart';
import '../entities/user_address_entity.dart';

abstract class UserAddressesRepository {
  Future<Result<List<UserAddressEntity>>> getAllAddresses();
  Future<Result<List<UserAddressEntity>>> deleteAddress(String id);
}
