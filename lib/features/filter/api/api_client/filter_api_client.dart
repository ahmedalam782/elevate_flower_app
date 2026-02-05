// features/filter/data/datasources/filter_api_client.dart

import 'package:dio/dio.dart';
import 'package:elevate_flower_app/features/categories/data/models/product_model/products_response_models.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/config/api/end_points.dart';

part 'filter_api_client.g.dart';

@RestApi(baseUrl: EndPoints.baseUrl)
@lazySingleton
abstract class FilterApiClient {
  @factoryMethod
  factory FilterApiClient(Dio dio) = _FilterApiClient;

  @GET(EndPoints.allProducts)
  Future<ProductsResponseModels> getProducts({
    @Query('sort') String? sort,
  });
}