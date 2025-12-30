import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/categories/data/models/category_response_model.dart';

abstract class CategoriesRemoteDataSourceContract {
  Future<Result<CategoryResponseModel>> getCategories();
}