// TODO: data Product_detailsRemoteDataSourceContract

import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/product_details/data/models/specefic_product_response/specefic_product_response.dart';

abstract class ProductDetailsRemoteDataSourceContract {
  Future<Result<SpeceficProductResponse>> getSpeceficProduct(String productId);
}
