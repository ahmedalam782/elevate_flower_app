import 'package:dio/dio.dart';
import 'package:elevate_flower_app/core/config/api/end_points.dart';
import 'package:elevate_flower_app/features/best_seller/data/models/best_seller_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
part 'best_seller_api_client.g.dart';

@injectable
@RestApi(baseUrl: EndPoints.baseUrl)
abstract class BestSellerApiClient {
  @factoryMethod
  factory BestSellerApiClient(Dio dio) => _BestSellerApiClient(dio);

  @GET(EndPoints.bestSellersEndpoint)
  Future<BestSellerResponseModel> getBestSellerProducts();
}
