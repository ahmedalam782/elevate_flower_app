// TODO: api ForgetPasswordRemoteDataSourceImpl

import 'package:elevate_flower_app/core/config/api/api_executer.dart';
import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/forget-password/api/api_client/forgetPassword_api_client.dart';
import 'package:elevate_flower_app/features/forget-password/data/datasources/forgetPassword_remote_data_source_contract.dart';
import 'package:elevate_flower_app/features/forget-password/data/models/forget_password_response/forget_password_response.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ForgetpasswordRemoteDataSourceContract)
class ForgetpasswordRemoteDataSourceImpl
    implements ForgetpasswordRemoteDataSourceContract {
  final ForgetpasswordApiClient forgetpasswordApiClient;

  ForgetpasswordRemoteDataSourceImpl({required this.forgetpasswordApiClient});

  @override
  Future<Result<ForgetPasswordResponse>> sendOtpToEmail(String email) async {
    return await executeApi<ForgetPasswordResponse>(() async {
      final response = await forgetpasswordApiClient.sendOtpToEmail(email);
      return response;
    });
  }
}
