import 'package:dio/dio.dart';
import '../../../../core/config/api/end_points.dart';
import '../../data/models/occasions_model.dart';
import '../../data/models/product_model.dart';
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
  @GET(EndPoints.getAllProducts)
  Future<ProductModel> getOccasionFlowers(@Query("occasion") String occasionId);
}
