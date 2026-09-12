import '../../../../core/config/base_response/result.dart';
import '../entities/product_entity.dart';
import '../repositories/categories_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetProductsUseCase {
  final CategoriesRepository _repository;

  GetProductsUseCase({required this._repository});

  Future<Result<List<ProductEntity>>> call(String? categoryId) async {
    return await _repository.getAllproducts(categoryId);
  }
}
