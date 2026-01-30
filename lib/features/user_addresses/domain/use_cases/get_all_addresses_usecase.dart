import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/user_addresses/domain/entities/user_address_entity.dart';
import 'package:elevate_flower_app/features/user_addresses/domain/repositories/user_addresses_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAllAddressesUsecase {
  final UserAddressesRepository _repository;

  GetAllAddressesUsecase(this._repository);

  Future<Result<List<UserAddressEntity>>> call() {
    return _repository.getAllAddresses();
  }
}