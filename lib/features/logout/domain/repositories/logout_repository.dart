
import '../../../../core/config/base_response/result.dart';
import '../../data/models/logout_response_model.dart';

abstract class LogoutRepository {
  Future<Result<LogoutResponseModel>> logout();
}