import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/forget-password/data/models/reset_password_dto/reset_password_dto.dart';
import 'package:elevate_flower_app/features/forget-password/domain/entities/forget_password_entity/forget_password_entity.dart';
import 'package:elevate_flower_app/features/forget-password/domain/repositories/forgetPassword_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class ResetPasswordUseCase {
  final ForgetpasswordRepository repo;

  ResetPasswordUseCase({required this.repo});
  Future<Result<void>> call(ResetPasswordDTo data) => repo.resetPassword(data);
}
