import 'package:injectable/injectable.dart';

import '../../../../core/config/base_response/result.dart';
import '../../data/models/reset_password_dto/reset_password_dto.dart';
import '../repositories/forget_Password_repository.dart';

@injectable
class ResetPasswordUseCase {
  final ForgetPasswordRepository repo;

  ResetPasswordUseCase({required this.repo});
  Future<Result<void>> call(ResetPasswordDTo data) => repo.resetPassword(data);
}
