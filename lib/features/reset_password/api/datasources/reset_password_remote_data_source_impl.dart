import '../api_client/reset_password_api_client.dart';
import '../../data/datasources/reset_password_remote_data_source_contract.dart';
import '../../data/models/change_password_request_model.dart';
import '../../data/models/change_password_response_model.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ResetPasswordRemoteDataSource)
class ResetPasswordRemoteDataSourceImpl
    implements ResetPasswordRemoteDataSource {
  final ResetPasswordApiClient _apiClient;

  ResetPasswordRemoteDataSourceImpl(this._apiClient);

  @override
  Future<ChangePasswordResponseModel> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      final requestBody = ChangePasswordRequestModel(
        password: currentPassword,
        newPassword: newPassword,
      );

      return await _apiClient.changePassword(requestBody);
    } catch (e) {
      throw Exception(e);
    }
  }
}
