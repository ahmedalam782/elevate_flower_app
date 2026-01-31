import 'package:dio/dio.dart';
import '../../../../core/config/api/api_executer.dart';
import '../../../../core/config/base_response/result.dart';
import '../api_client/edit_profile_api_client.dart';
import '../../data/datasources/edit_profile_remote_data_source_contract.dart';
import '../../data/models/edit_profile_request_body.dart';
import '../../data/models/edit_profile_response_dto.dart';
import 'package:injectable/injectable.dart';


@Injectable(as: EditProfileRemoteDataSourceContract)
class EditProfileRemoteDataSourceImpl
    implements EditProfileRemoteDataSourceContract {
  EditProfileRemoteDataSourceImpl(this._apiClient);
  final EditProfileApiClient _apiClient;

  @override
  Future<Result<EditProfileResponseDto>> getProfileDetails() {
    return executeApi<EditProfileResponseDto>(
      () => _apiClient.getProfileDetails(),
    );
  }

  @override
  Future<Result<EditProfileResponseDto>> updateProfileDetails(
    EditProfileRequestBody params,
  ) {
    return executeApi<EditProfileResponseDto>(
      () => _apiClient.updateProfileDetails(params),
    );
  }
  
  @override
  Future<Result<String>> updateProfilePhoto(MultipartFile image) async {
    return executeApi<String>(
      () => _apiClient.updateProfilePhoto(image),
    );
  }
}
