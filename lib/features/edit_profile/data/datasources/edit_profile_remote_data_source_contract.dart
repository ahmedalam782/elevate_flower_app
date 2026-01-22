import 'package:dio/dio.dart';
import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/edit_profile/data/models/edit_profile_request_body.dart';
import 'package:elevate_flower_app/features/edit_profile/data/models/edit_profile_response_dto.dart';

abstract class EditProfileRemoteDataSourceContract {
  Future<Result<EditProfileResponseDto>> getProfileDetails();
  Future<Result<EditProfileResponseDto>> updateProfileDetails(EditProfileRequestBody params);
  Future<Result<String>> updateProfilePhoto(MultipartFile image);
}
