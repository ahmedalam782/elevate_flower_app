import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/forget-password/domain/entities/forget_password_entity/forget_password_entity.dart';
import 'package:elevate_flower_app/features/forget-password/domain/repositories/forgetPassword_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class VerifyOtpUseCase {
  final ForgetpasswordRepository repo;

  VerifyOtpUseCase({required this.repo});
  Future<Result<void>> call(String code) => repo.verifyCode(code);
}
