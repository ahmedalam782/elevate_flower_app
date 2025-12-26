import 'package:elevate_flower_app/features/register/domain/repositories/register_repository.dart';
import 'package:injectable/injectable.dart';
@injectable
class SaveTokenUseCase {
  final RegisterRepository _repository;

  SaveTokenUseCase(this._repository);

  Future<void> call(String token) {
    return _repository.saveAuthToken(token);
  }
}