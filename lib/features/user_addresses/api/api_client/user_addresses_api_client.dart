import 'package:dio/dio.dart';
import '../../../../core/config/api/end_points.dart';
import '../../data/models/get_all_addresses_response.dart';
import '../../data/models/remove_address_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
part 'user_addresses_api_client.g.dart';

@injectable
@RestApi(baseUrl: EndPoints.baseUrl)
abstract class UserAddressesApiClient {
  @factoryMethod
  factory UserAddressesApiClient(Dio dio) = _UserAddressesApiClient;
  @GET(EndPoints.addressEndPoint)
  Future<GetAllAddressesResponse> getAllAddresses();

  @DELETE("${EndPoints.addressEndPoint}/{id}")
  Future<RemoveAddressResponse> deleteAddress(@Path("id") String id);
}
