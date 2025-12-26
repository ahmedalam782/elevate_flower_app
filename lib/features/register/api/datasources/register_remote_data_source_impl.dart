import 'package:elevate_flower_app/core/config/api/api_executer.dart';
import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/register/api/api_client/register_api_client.dart';
import 'package:elevate_flower_app/features/register/data/datasources/register_remote_data_source_contract.dart';
import 'package:elevate_flower_app/features/register/data/models/register_request_body.dart';
import 'package:elevate_flower_app/features/register/data/models/register_user_response_dto.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: RegisterRemoteDataSourceContract)
class RegisterRemoteDataSourceImpl implements RegisterRemoteDataSourceContract {
  final RegisterApiClient _apiClient;

  RegisterRemoteDataSourceImpl(this._apiClient);

  @override
  Future<Result<RegisterUserResponseDto>> registerUser(RegisterRequestBody user) async{
    return await executeApi<RegisterUserResponseDto>(  
      () => _apiClient.registerUser(user),
    );
  }
}
