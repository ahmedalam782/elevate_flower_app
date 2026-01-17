import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/register/data/datasources/register_local_data_source_contract.dart';
import 'package:elevate_flower_app/features/register/data/datasources/register_remote_data_source_contract.dart';
import 'package:elevate_flower_app/features/register/data/models/register_request_body.dart';
import 'package:elevate_flower_app/features/register/domain/entities/register_params.dart';
import 'package:elevate_flower_app/features/register/domain/entities/register_user_response.dart';
import 'package:elevate_flower_app/features/register/domain/repositories/register_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: RegisterRepository)
class RegisterRepositoryImpl implements RegisterRepository {
  final RegisterRemoteDataSourceContract _remoteDataSource;
  final RegisterLocalDataSourceContract _localDataSource;
  RegisterRepositoryImpl(this._remoteDataSource, this._localDataSource);
  @override
  Future<Result<RegisterUserResponse>> registerUser({
    required RegisterParams params,
  }) async {
    final requestBody = RegisterRequestBody.fromEntity(params);
    final result = await _remoteDataSource.registerUser(requestBody);
    return result.when(success: (data) {
      return Success<RegisterUserResponse>(data:data?.toEntity());
    }, error: (exception){
      return Error<RegisterUserResponse>(exception: exception);
    });
  }

  @override
  Future<void> saveAuthToken(String token) {
    return _localDataSource.saveAuthToken(token);
  }
}
