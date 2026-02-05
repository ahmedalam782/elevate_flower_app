import '../../../../core/config/base_response/result.dart';
import 'package:injectable/injectable.dart';
import '../entities/change_password_entity.dart';
import '../repositories/reset_password_repository.dart';

@lazySingleton
class ChangePasswordUseCase {
  final ResetPasswordRepository repository;

  ChangePasswordUseCase({required this.repository});

  Future<Result<ChangePasswordEntity>> call({
    required String currentPassword,
    required String newPassword,
  }) async {
    return await repository.changePassword(
      currentPassword: currentPassword,
      newPassword: newPassword,
    );
  }
}
