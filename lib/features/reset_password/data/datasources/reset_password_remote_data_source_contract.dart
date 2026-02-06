import '../models/change_password_response_model.dart';

abstract class ResetPasswordRemoteDataSource {
  Future<ChangePasswordResponseModel> changePassword({
    required String currentPassword,
    required String newPassword,
  });
}
