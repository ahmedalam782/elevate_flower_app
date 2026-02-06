
import '../../../../core/config/base_response/result.dart';
import '../../data/models/reset_password_dto/reset_password_dto.dart';
import '../entities/forget_password_entity/forget_password_entity.dart';

abstract class ForgetPasswordRepository {
  Future<Result<ForgetPasswordEntity>> sendOtpToEmail(String email);
  Future<Result<void>> verifyCode(String code);
  Future<Result<void>> resetPassword(ResetPasswordDTo data);
}
