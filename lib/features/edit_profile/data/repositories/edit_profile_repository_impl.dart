import 'dart:io';
import 'package:dio/dio.dart';
import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/edit_profile/data/datasources/edit_profile_remote_data_source_contract.dart';
import 'package:elevate_flower_app/features/edit_profile/data/models/edit_profile_request_body.dart';
import 'package:elevate_flower_app/features/edit_profile/domain/entities/edit_profile_params.dart';
import 'package:elevate_flower_app/features/edit_profile/domain/entities/edit_profile_user_entity.dart';
import 'package:elevate_flower_app/features/edit_profile/domain/repositories/edit_profile_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: EditProfileRepository)
class EditProfileRepositoryImpl implements EditProfileRepository {
  EditProfileRepositoryImpl(this._editProfileDataSource);
  final EditProfileRemoteDataSourceContract _editProfileDataSource;
  @override
  Future<Result<EditProfileUserEntity>> getProfileDetails() async {
    final result = await _editProfileDataSource.getProfileDetails();
    return result.when(
      success: (data) {
        return Success<EditProfileUserEntity>(data: data?.user?.toEntity());
      },
      error: (exception) {
        return Error<EditProfileUserEntity>(exception: exception);
      },
    );
  }

  @override
  Future<Result<EditProfileUserEntity>> updateProfileDetails(
    EditProfileParams params,
  ) async {
    final param = EditProfileRequestBody.fromEntity(params);
    final result = await _editProfileDataSource.updateProfileDetails(param);
    return result.when(
      success: (data) {
        return Success<EditProfileUserEntity>(data: data?.user?.toEntity());
      },
      error: (exception) {
        return Error<EditProfileUserEntity>(exception: exception);
      },
    );
  }

  @override
  Future<Result<String>> updateProfilePhoto(File image) async {
    final fileName = image.path.split('/').last;
    final multipart = await MultipartFile.fromFile(
      image.path,
      filename: fileName,
    );
    return _editProfileDataSource.updateProfilePhoto(multipart);
  }
}
