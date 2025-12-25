import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/register/domain/entities/register_params.dart';
import 'package:elevate_flower_app/features/register/domain/entities/register_user_response.dart';
import 'package:elevate_flower_app/features/register/domain/repositories/register_repository.dart';
import 'package:injectable/injectable.dart';
@injectable
class RegisterUserUseCase {
  final RegisterRepository repository;

  RegisterUserUseCase(this.repository);

  Future<Result<RegisterUserResponse>> call(RegisterParams params) {
    return repository.registerUser(params: params);
  }
}
