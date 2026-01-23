import 'package:elevate_flower_app/features/logout/data/models/logout_response_model.dart';

abstract class LogoutRemoteDataSource {
  Future<LogoutResponseModel> logout();
}