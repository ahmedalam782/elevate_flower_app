import 'package:dio/dio.dart';
import '../../../../core/config/api/end_points.dart';
import '../../data/models/search_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'search_api_client.g.dart';

@injectable
@RestApi(baseUrl: EndPoints.baseUrl)
abstract class SearchApiClient {
  @factoryMethod
  factory SearchApiClient(Dio dio) => _SearchApiClient(dio);

  @GET(EndPoints.productsEndpoint)
  Future<SearchResponseModel> searchProducts(
    @Query(QueryParameter.keyword) String keyword,
    @Query(QueryParameter.page) int page,
    @Query(QueryParameter.limit) int limit,
  );
}
