// TODO: api ForgetPasswordApiClient

import 'package:dio/dio.dart';
import 'package:elevate_flower_app/core/config/api/end_points.dart';
import 'package:elevate_flower_app/features/forget-password/data/models/forget_password_response/forget_password_response.dart';
import 'package:elevate_flower_app/features/forget-password/data/models/reset_password_dto/reset_password_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
part 'forgetPassword_api_client.g.dart';

@injectable
@RestApi(baseUrl: EndPoints.baseUrl)
abstract class ForgetpasswordApiClient {
  @factoryMethod
  factory ForgetpasswordApiClient(Dio dio) = _ForgetpasswordApiClient;

  @POST(EndPoints.forgetPasswordEndpoint)
  Future<ForgetPasswordResponse> sendOtpToEmail(
    @Body() Map<String, String> map,
  );
  @POST(EndPoints.verifyResetEndpoint)
  Future<void> verifyCode(@Body() Map<String, String> map);
  @PUT(EndPoints.resetPasswordEndpoint)
  Future<void> resetPassword(@Body() ResetPasswordDTo data);
}
