// TODO: api Address_detailsApiClient
import 'package:dio/dio.dart';
import 'package:elevate_flower_app/core/config/api/end_points.dart';
import 'package:elevate_flower_app/features/address_details/data/models/address_details_data.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part "address_details_api_client.g.dart";

@injectable
@RestApi(baseUrl: EndPoints.baseUrl)
abstract class AddressDetailsApiClient {
  @factoryMethod
  factory AddressDetailsApiClient(Dio dio) = _AddressDetailsApiClient;

  @PATCH(EndPoints.addressEndPoint)
  Future<void> addAddress(@Body() AddressDetailsData data);
  @PATCH("${EndPoints.addressEndPoint}/{id}")
  Future<void> updateAddress(
    @Body() AddressDetailsData data,
    @Path() String id,
  );
}
