import '../../../../core/config/base_response/result.dart';
import '../models/register_request_body.dart';
import '../models/register_user_response_dto.dart';

abstract class RegisterRemoteDataSourceContract {
  Future<Result<RegisterUserResponseDto>> registerUser(RegisterRequestBody user);
}
