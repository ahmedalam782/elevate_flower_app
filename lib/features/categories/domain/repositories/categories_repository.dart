import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/categories/domain/entities/category_entity.dart';
import 'package:elevate_flower_app/features/categories/domain/entities/product_entity.dart';

abstract class CategoriesRepository {
  
  Future<Result<List<CategoryEntity>>> getallCategories();

  Future<Result<List<ProductEntity>>> getallproducts(String categoryId);
}
