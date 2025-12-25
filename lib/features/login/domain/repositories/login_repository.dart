import 'package:elevate_flower_app/features/login/data/models/login_response_model.dart';

import '../../../../core/config/base_response/result.dart';
import '../entities/login_response_entity.dart';

abstract class LoginRepository {
  Future<Result<LoginResponseModel>> loginUser({
    required String email,
    required String password,
    required bool rememberMe,
  });
}