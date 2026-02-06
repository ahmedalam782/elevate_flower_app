import '../../../../core/config/base_response/result.dart';
import '../entities/register_params.dart';
import '../entities/register_user_response.dart';

abstract class RegisterRepository {
  Future<Result<RegisterUserResponse>> registerUser({
    required RegisterParams params,
  });

  Future<void> saveAuthToken(String token);
}
