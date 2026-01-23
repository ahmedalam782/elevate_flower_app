import '../../../../core/config/base_response/result.dart';
import '../models/profile_response_model.dart';

abstract class ProfileRemoteDataSourceContract {
  Future<Result<ProfileResponseModel>> getProfileData();
}
