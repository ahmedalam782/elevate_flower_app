// TODO: data ForgetPasswordRemoteDataSourceContract

import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/forget-password/data/models/forget_password_response/forget_password_response.dart';
import 'package:elevate_flower_app/features/forget-password/data/models/reset_password_dto/reset_password_dto.dart';

abstract class ForgetpasswordRemoteDataSourceContract {
  Future<Result<ForgetPasswordResponse>> sendOtpToEmail(String email);
  Future<Result<void>> verifyCode(String code);
  Future<Result<void>> resetPassword(ResetPasswordDTo resetPasswordDto);
}
