import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/reset_password/domain/entities/change_password_entity.dart';

abstract class ResetPasswordRepository {
  Future<Result<ChangePasswordEntity>> changePassword({
    required String currentPassword,
    required String newPassword,
  });
}
