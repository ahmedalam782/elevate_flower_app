import 'package:dio/dio.dart';
import 'package:elevate_flower_app/core/config/api/end_points.dart';
import 'package:elevate_flower_app/features/check_out/data/models/user_addresses_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
part 'user_addresses_api_client.g.dart';

@lazySingleton
@RestApi(baseUrl: EndPoints.baseUrl)
abstract class UserAddressesApiClient {
  @factoryMethod
  factory UserAddressesApiClient(Dio dio) = _UserAddressesApiClient;
  @GET(EndPoints.userAddresses)
  Future<UserAddressesResponse> getUserAddresses();
}