import 'package:dio/dio.dart';
import '../../../../core/config/api/end_points.dart';
import '../../data/models/register_request_body.dart';
import '../../data/models/register_user_response_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
part 'register_api_client.g.dart';

@injectable
@RestApi(baseUrl: EndPoints.baseUrl)
abstract class RegisterApiClient {
  @factoryMethod
   factory RegisterApiClient(Dio dio) = _RegisterApiClient;


  @POST(EndPoints.register)
  Future<RegisterUserResponseDto> registerUser(
    @Body() RegisterRequestBody body,
  );
}
