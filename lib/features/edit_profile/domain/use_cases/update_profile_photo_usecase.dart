import 'dart:io';

import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/edit_profile/domain/repositories/edit_profile_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateProfilePhotoUsecase {
  final EditProfileRepository _repository;
  UpdateProfilePhotoUsecase(this._repository);
  Future<Result<String>> call(File image) => _repository.updateProfilePhoto(image);
}