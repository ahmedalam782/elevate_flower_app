import '../../../../core/config/base_response/result.dart';
import '../entities/change_password_entity.dart';

abstract class ResetPasswordRepository {
  Future<Result<ChangePasswordEntity>> changePassword({
    required String currentPassword,
    required String newPassword,
  });
}
