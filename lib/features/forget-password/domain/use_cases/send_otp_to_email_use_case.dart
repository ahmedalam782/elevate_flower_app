import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/forget-password/domain/entities/forget_password_entity/forget_password_entity.dart';
import 'package:elevate_flower_app/features/forget-password/domain/repositories/forgetPassword_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class SendOtpToEmailUseCase {
  final ForgetpasswordRepository repo;

  SendOtpToEmailUseCase({required this.repo});
  Future<Result<ForgetPasswordEntity>> call(String email) =>
      repo.sendOtpToEmail(email);
}
