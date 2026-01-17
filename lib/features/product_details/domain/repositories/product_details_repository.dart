// TODO: domain Product_detailsRepository

import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/product_details/domain/entities/specefic_product_entity.dart';

abstract class ProductDetailsRepository {
  Future<Result<SpeceficProductEntity>> getSpeceficProduct(String productId);
}
