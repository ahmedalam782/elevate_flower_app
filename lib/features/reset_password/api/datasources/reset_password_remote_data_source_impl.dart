import 'package:dio/dio.dart';
import 'package:elevate_flower_app/core/config/api/end_points.dart';
import 'package:elevate_flower_app/features/reset_password/data/datasources/reset_password_remote_data_source_contract.dart';
import 'package:elevate_flower_app/features/reset_password/data/models/change_password_request_model.dart';
import 'package:elevate_flower_app/features/reset_password/data/models/change_password_response_model.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ResetPasswordRemoteDataSource)
class ResetPasswordRemoteDataSourceImpl
    implements ResetPasswordRemoteDataSource {
  final Dio dio;

  ResetPasswordRemoteDataSourceImpl({required this.dio});

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

      final response = await dio.patch(
        EndPoints.changePassword,
        data: requestBody.toJson(),
      );

      return ChangePasswordResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(
          e.response?.data['message'] ?? 'Failed to change password',
        );
      }
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}