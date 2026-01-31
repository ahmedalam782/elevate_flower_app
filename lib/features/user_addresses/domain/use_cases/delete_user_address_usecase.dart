import '../../../../core/config/base_response/result.dart';
import '../entities/user_address_entity.dart';
import '../repositories/user_addresses_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class DeleteUserAddressUsecase {
  final UserAddressesRepository _repository;

  DeleteUserAddressUsecase(this._repository);

  Future<Result<List<UserAddressEntity>>> call(String id) {
    return _repository.deleteAddress(id);
  }
}