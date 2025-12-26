import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/register/data/models/register_request_body.dart';
import 'package:elevate_flower_app/features/register/data/models/register_user_response_dto.dart';

abstract class RegisterRemoteDataSourceContract {
  Future<Result<RegisterUserResponseDto>> registerUser(RegisterRequestBody user);
}
