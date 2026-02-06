import '../../../../core/config/base_response/result.dart';
import '../models/category_model/category_response_model.dart';
import '../models/product_model/products_response_models.dart';

abstract class CategoriesRemoteDataSourceContract {
  Future<Result<CategoryResponseModel>> getAllCategories();

  Future<Result<ProductsResponseModels>> getAllProducts(String? categoryId);
}
