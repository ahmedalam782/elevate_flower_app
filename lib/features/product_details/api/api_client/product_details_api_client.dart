// TODO: api Product_detailsApiClient
import 'package:dio/dio.dart';
import 'package:elevate_flower_app/core/config/api/end_points.dart';
import 'package:elevate_flower_app/features/product_details/data/models/specefic_product_response/specefic_product_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
part 'product_details_api_client.g.dart';

@injectable
@RestApi(baseUrl: EndPoints.baseUrl)
abstract class ProductDetailsApiClient {
  @factoryMethod
  factory ProductDetailsApiClient(Dio dio) = _ProductDetailsApiClient;

  @GET("${EndPoints.productsEndpoint}/{id}")
  Future<SpeceficProductResponse> getSpeceficProduct(@Path("id") String id);
}
