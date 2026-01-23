import 'package:dio/dio.dart';
import 'package:elevate_flower_app/features/reset_password/data/models/change_password_request_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/config/api/end_points.dart';

part 'reset_password_api_client.g.dart';

@RestApi(baseUrl: EndPoints.baseUrl)
@lazySingleton
abstract class ResetPasswordApiClient {
  @factoryMethod
  factory ResetPasswordApiClient(Dio dio) = _ResetPasswordApiClient;

  @PATCH(EndPoints.changePassword)
  Future<ChangePasswordRequestModel> changePassword(
    @Body() Map<String, dynamic> body,
  );
}
