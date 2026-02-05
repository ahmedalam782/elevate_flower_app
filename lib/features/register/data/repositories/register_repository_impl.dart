import '../../../../core/config/base_response/result.dart';
import '../datasources/register_local_data_source_contract.dart';
import '../datasources/register_remote_data_source_contract.dart';
import '../models/register_request_body.dart';
import '../../domain/entities/register_params.dart';
import '../../domain/entities/register_user_response.dart';
import '../../domain/repositories/register_repository.dart';
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
