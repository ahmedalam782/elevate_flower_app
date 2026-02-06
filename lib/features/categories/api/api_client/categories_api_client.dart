import 'package:dio/dio.dart';
import '../../data/models/category_model/category_response_model.dart';
import '../../data/models/product_model/products_response_models.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/config/api/end_points.dart';

part 'categories_api_client.g.dart';

@RestApi(baseUrl: EndPoints.baseUrl)
@lazySingleton
abstract class CategoriesApiClient {
  @factoryMethod
  factory CategoriesApiClient(Dio dio) = _CategoriesApiClient;

  @GET(EndPoints.allCategories)
  Future<CategoryResponseModel> getAllCategories();

  @GET(EndPoints.allProducts)
  Future<ProductsResponseModels> getAllProducts(
    @Query(QueryParameter.categoryQuery) String? categoryId,
  );
}
