import 'dart:io';

import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/edit_profile/domain/entities/edit_profile_params.dart';
import 'package:elevate_flower_app/features/edit_profile/domain/entities/edit_profile_user_entity.dart';

abstract class EditProfileRepository {
  Future<Result<EditProfileUserEntity>> getProfileDetails();
  Future<Result<EditProfileUserEntity>> updateProfileDetails(
    EditProfileParams params,
  );
  Future<Result<String>> updateProfilePhoto(File image);
}
