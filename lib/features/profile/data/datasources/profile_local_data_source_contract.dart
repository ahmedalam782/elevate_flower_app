import '../../domain/entities/profile_data_entity.dart';

abstract class ProfileLocalDataSourceContract {
  Future<void> saveProfileData(ProfileDataEntity profile);
  Future<ProfileDataEntity?> getProfileData();
  Future<void> clearProfileData();
}
