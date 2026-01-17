import 'package:injectable/injectable.dart';

import '../../../../core/config/base_response/result.dart';
import '../repositories/forget_Password_repository.dart';

@injectable
class VerifyOtpUseCase {
  final ForgetPasswordRepository repo;

  VerifyOtpUseCase({required this.repo});
  Future<Result<void>> call(String code) => repo.verifyCode(code);
}
