import '../models/logout_response_model.dart';

abstract class LogoutRemoteDataSource {
  Future<LogoutResponseModel> logout();
}