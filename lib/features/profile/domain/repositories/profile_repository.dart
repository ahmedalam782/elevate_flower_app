import '../../../../core/config/base_response/result.dart';
import '../entities/profile_data_entity.dart';

abstract class ProfileRepository {
  Future<Result<ProfileDataEntity>> getProfileData();
}
