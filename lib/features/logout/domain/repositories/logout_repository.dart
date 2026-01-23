
import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/logout/data/models/logout_response_model.dart';

abstract class LogoutRepository {
  Future<Result<LogoutResponseModel>> logout();
}