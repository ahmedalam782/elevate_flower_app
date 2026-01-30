// features/filter/domain/repositories/filter_repository.dart

import 'package:elevate_flower_app/features/categories/data/models/product_model/products_response_models.dart';
import 'package:elevate_flower_app/features/filter/domain/entities/filter_type.dart';

abstract class FilterRepository {
  Future<ProductsResponseModels> getFilteredProducts(FilterType? filterType);
  Future<ProductsResponseModels> getAllProducts();
}