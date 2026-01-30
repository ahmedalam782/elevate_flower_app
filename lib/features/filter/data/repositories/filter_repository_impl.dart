// features/filter/data/repositories/filter_repository_impl.dart

import 'package:elevate_flower_app/features/categories/data/models/product_model/products_response_models.dart';
import 'package:elevate_flower_app/features/filter/api/api_client/filter_api_client.dart';
import 'package:elevate_flower_app/features/filter/domain/entities/filter_type.dart';
import 'package:elevate_flower_app/features/filter/domain/repositories/filter_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: FilterRepository)
class FilterRepositoryImpl implements FilterRepository {
  final FilterApiClient apiClient;

  FilterRepositoryImpl(this.apiClient);

  @override
  Future<ProductsResponseModels> getFilteredProducts(FilterType? filterType) async {
    try {
      final sortValue = filterType?.queryValue;
      return await apiClient.getProducts(sort: sortValue);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ProductsResponseModels> getAllProducts() async {
    try {
      return await apiClient.getProducts();
    } catch (e) {
      rethrow;
    }
  }
}