import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/categories/domain/entities/product_entity.dart';
import 'package:elevate_flower_app/features/categories/domain/repositories/categories_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetProductsUseCase {
  final CategoriesRepository _repository;

  GetProductsUseCase({required CategoriesRepository repository})
    : _repository = repository;

  Future<Result<List<ProductEntity>>> call(String categoryId) async {
    return await _repository.getAllproducts(categoryId);
  }
}
