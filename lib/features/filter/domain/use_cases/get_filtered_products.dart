// features/filter/domain/usecases/get_filtered_products.dart

import 'package:elevate_flower_app/features/categories/data/models/product_model/products_response_models.dart';
import 'package:elevate_flower_app/features/filter/domain/entities/filter_type.dart';
import 'package:elevate_flower_app/features/filter/domain/repositories/filter_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetFilteredProducts {
  final FilterRepository repository;

  GetFilteredProducts(this.repository);

  Future<ProductsResponseModels> call(FilterType? filterType) async {
    if (filterType == null) {
      return await repository.getAllProducts();
    }
    return await repository.getFilteredProducts(filterType);
  }
}