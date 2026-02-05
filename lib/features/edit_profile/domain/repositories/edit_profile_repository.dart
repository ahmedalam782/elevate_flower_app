import 'dart:io';

import '../../../../core/config/base_response/result.dart';
import '../entities/edit_profile_params.dart';
import '../entities/edit_profile_user_entity.dart';

abstract class EditProfileRepository {
  Future<Result<EditProfileUserEntity>> getProfileDetails();
  Future<Result<EditProfileUserEntity>> updateProfileDetails(
    EditProfileParams params,
  );
  Future<Result<String>> updateProfilePhoto(File image);
}
