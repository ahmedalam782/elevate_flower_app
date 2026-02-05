import 'package:injectable/injectable.dart';

import '../../../../core/config/base_response/result.dart';
import '../../data/datasources/profile_remote_data_source_contract.dart';
import '../../data/models/profile_response_model.dart';
import '../api_client/profile_api_client.dart';

@Injectable(as: ProfileRemoteDataSourceContract)
class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSourceContract {
  final ProfileApiClient _apiClient;

  ProfileRemoteDataSourceImpl(this._apiClient);

  @override
  Future<Result<ProfileResponseModel>> getProfileData() async {
    try {
      final response = await _apiClient.getProfileData();
      return Success<ProfileResponseModel>(data: response);
    } catch (exception) {
      return Error<ProfileResponseModel>(
        exception: Exception(exception.toString()),
      );
    }
  }
}
