import '../../../../core/config/base_response/result.dart';
import '../entities/register_params.dart';
import '../entities/register_user_response.dart';
import '../repositories/register_repository.dart';
import 'package:injectable/injectable.dart';
@injectable
class RegisterUserUseCase {
  final RegisterRepository repository;

  RegisterUserUseCase(this.repository);

  Future<Result<RegisterUserResponse>> call(RegisterParams params) {
    return repository.registerUser(params: params);
  }
}
