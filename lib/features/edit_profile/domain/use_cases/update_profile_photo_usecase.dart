import 'dart:io';

import '../../../../core/config/base_response/result.dart';
import '../repositories/edit_profile_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateProfilePhotoUsecase {
  final EditProfileRepository _repository;
  UpdateProfilePhotoUsecase(this._repository);
  Future<Result<String>> call(File image) => _repository.updateProfilePhoto(image);
}