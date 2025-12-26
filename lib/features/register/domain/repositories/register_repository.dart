import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/register/domain/entities/register_params.dart';
import 'package:elevate_flower_app/features/register/domain/entities/register_user_response.dart';

abstract class RegisterRepository {
  Future<Result<RegisterUserResponse>> registerUser({
    required RegisterParams params,
  });

  Future<void> saveAuthToken(String token);
}
