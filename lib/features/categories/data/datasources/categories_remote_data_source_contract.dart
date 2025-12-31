import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/categories/data/models/category_model/category_response_model.dart';
import 'package:elevate_flower_app/features/categories/data/models/product_model/products_response_models.dart';

abstract class CategoriesRemoteDataSourceContract {
  Future<Result<CategoryResponseModel>> getCategories();

  Future<Result<ProductsResponseModels>> getProducts();
}
