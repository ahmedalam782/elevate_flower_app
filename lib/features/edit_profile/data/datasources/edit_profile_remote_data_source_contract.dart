import 'package:dio/dio.dart';
import '../../../../core/config/base_response/result.dart';
import '../models/edit_profile_request_body.dart';
import '../models/edit_profile_response_dto.dart';

abstract class EditProfileRemoteDataSourceContract {
  Future<Result<EditProfileResponseDto>> getProfileDetails();
  Future<Result<EditProfileResponseDto>> updateProfileDetails(EditProfileRequestBody params);
  Future<Result<String>> updateProfilePhoto(MultipartFile image);
}
