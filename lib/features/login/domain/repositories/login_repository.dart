
import '../../../../core/config/base_response/result.dart';
import '../entities/login_response_entity.dart';
abstract class LoginRepository {
  Future<Result<LoginResponseEntity>> loginUser({
    required String email,
    required String password,
    required bool rememberMe,
  });
}