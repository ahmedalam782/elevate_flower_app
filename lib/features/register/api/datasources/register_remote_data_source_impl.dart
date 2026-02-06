import '../../../../core/config/api/api_executer.dart';
import '../../../../core/config/base_response/result.dart';
import '../api_client/register_api_client.dart';
import '../../data/datasources/register_remote_data_source_contract.dart';
import '../../data/models/register_request_body.dart';
import '../../data/models/register_user_response_dto.dart';
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
