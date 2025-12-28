import 'package:dio/dio.dart';
import 'package:elevate_flower_app/core/config/api/end_points.dart';
import 'package:elevate_flower_app/features/occasions/data/models/occasions_model.dart';
import 'package:elevate_flower_app/features/occasions/data/models/product_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'occasions_api_client.g.dart';

@lazySingleton
@RestApi(baseUrl: EndPoints.baseUrl)
abstract class OccasionsApiClient {
  @factoryMethod
  factory OccasionsApiClient(Dio dio) = _OccasionsApiClient;

  @GET(EndPoints.getAllOccasions)
  Future<OccasionModel> getOccasions();
  @GET(EndPoints.getOcccasionFlowers)
  Future<ProductModel> getOccasionFlowers(
    @Path("occasionId") String occasionId,
  );
}
