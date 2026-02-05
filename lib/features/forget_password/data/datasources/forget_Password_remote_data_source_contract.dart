import '../../../../core/config/base_response/result.dart';

import '../models/forget_password_response/forget_password_response.dart';
import '../models/reset_password_dto/reset_password_dto.dart';

abstract class ForgetPasswordRemoteDataSourceContract {
  Future<Result<ForgetPasswordResponse>> sendOtpToEmail(String email);
  Future<Result<void>> verifyCode(String code);
  Future<Result<void>> resetPassword(ResetPasswordDTo resetPasswordDto);
}
