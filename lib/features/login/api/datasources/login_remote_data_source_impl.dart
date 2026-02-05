import 'package:dio/dio.dart';
import '../../data/datasources/login_remote_data_source_contract.dart';
import '../../data/models/login_request_model.dart';
import '../../data/models/login_response_model.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/config/base_response/result.dart';
import '../../../../core/errors/failures.dart';
import '../../api/api_client/login_api_client.dart';

@LazySingleton(as: LoginRemoteDataSourceContract)
class LoginRemoteDataSourceImpl implements LoginRemoteDataSourceContract {
  final LoginApiClient apiClient;

  LoginRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<Result<LoginResponseModel>> loginUser({
    required LoginRequestModel body,
    required bool rememberMe,
  }) async {
    try {
      final response = await apiClient.login(body);
      return Success<LoginResponseModel>(data: response);
    } on DioException catch (dioException) {
      return Error<LoginResponseModel>(
        exception: ServerFailure.fromDioException(dioException: dioException),
      );
    } catch (e) {
      return Error<LoginResponseModel>(
        exception: Exception(e.toString()),
      );
    }
  }
}