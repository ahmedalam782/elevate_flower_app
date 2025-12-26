import 'package:injectable/injectable.dart';

import '../../../../core/config/base_response/result.dart';
import '../entities/forget_password_entity/forget_password_entity.dart';
import '../repositories/forget_Password_repository.dart';

@injectable
class SendOtpToEmailUseCase {
  final ForgetPasswordRepository repo;

  SendOtpToEmailUseCase({required this.repo});
  Future<Result<ForgetPasswordEntity>> call(String email) =>
      repo.sendOtpToEmail(email);
}
