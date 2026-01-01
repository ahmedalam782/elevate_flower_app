import 'package:dio/dio.dart';
import 'package:elevate_flower_app/features/categories/data/models/category_model/category_response_model.dart';
import 'package:elevate_flower_app/features/categories/data/models/product_model/products_response_models.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/config/api/end_points.dart';

part 'categories_api_client.g.dart';

@RestApi(baseUrl: EndPoints.baseUrl)
@lazySingleton
abstract class CategoriesApiClient {
  @factoryMethod
  factory CategoriesApiClient(Dio dio) = _CategoriesApiClient;

  @GET(EndPoints.allcategories)
  Future<CategoryResponseModel> getallCategories();

  @GET(EndPoints.allproducts)
  Future<ProductsResponseModels> getallproducts(
    @Query("category") String categoryId,
  );
}
