import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/config/api/end_points.dart';
import '../../data/models/login_request_model.dart';
import '../../data/models/login_response_model.dart';

part 'login_api_client.g.dart';

@RestApi(baseUrl: EndPoints.baseUrl)
@lazySingleton
abstract class LoginApiClient {
  @factoryMethod
  factory LoginApiClient(Dio dio) = _LoginApiClient;

  @POST(EndPoints.login)
  Future<LoginResponseModel> login(@Body() LoginRequestModel request);
}
