import '../../../../core/config/base_response/result.dart';
import '../models/login_request_model.dart';
import '../models/login_response_model.dart';

abstract class LoginRemoteDataSourceContract {
  Future<Result<LoginResponseModel>> loginUser({
    required LoginRequestModel body,
    required bool rememberMe,
  });
}