// TODO: domain ForgetPasswordRepository

import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/forget-password/domain/entities/forget_password_entity/forget_password_entity.dart';

abstract class ForgetpasswordRepository {
  Future<Result<ForgetPasswordEntity>> sendOtpToEmail(String email);
}
