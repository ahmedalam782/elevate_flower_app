import 'package:dio/dio.dart';
import 'package:elevate_flower_app/core/config/api/end_points.dart';
import 'package:elevate_flower_app/features/edit_profile/data/models/edit_profile_request_body.dart';
import 'package:elevate_flower_app/features/edit_profile/data/models/edit_profile_response_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'edit_profile_api_client.g.dart';

@injectable
@RestApi(baseUrl: EndPoints.baseUrl)
abstract class EditProfileApiClient {
  @factoryMethod
  factory EditProfileApiClient(Dio dio) = _EditProfileApiClient;
  @GET(EndPoints.getUserProfile)
  Future<EditProfileResponseDto> getProfileDetails();

  @PUT(EndPoints.editUserProfile)
  Future<EditProfileResponseDto> updateProfileDetails(
    @Body() EditProfileRequestBody params,
  );

  @PUT(EndPoints.updateProfilePhoto)
  @MultiPart()
  Future<String> updateProfilePhoto(@Part(name: "photo") MultipartFile photo);
}
