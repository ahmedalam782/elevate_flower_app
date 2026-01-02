import 'package:elevate_flower_app/core/config/api/api_executer.dart';
import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/categories/api/api_client/categories_api_client.dart';
import 'package:elevate_flower_app/features/categories/data/datasources/categories_remote_data_source_contract.dart';
import 'package:elevate_flower_app/features/categories/data/models/category_model/category_response_model.dart';
import 'package:elevate_flower_app/features/categories/data/models/product_model/products_response_models.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CategoriesRemoteDataSourceContract)
class CategoriesRemoteDataSourceImpl
    implements CategoriesRemoteDataSourceContract {
  final CategoriesApiClient _apiClient;

  CategoriesRemoteDataSourceImpl({required CategoriesApiClient apiClient})
    : _apiClient = apiClient;

  @override
  Future<Result<CategoryResponseModel>> getAllCategories() async {
    return await executeApi(() async {
      final response = await _apiClient.getAllCategories();
      return response;
    });
  }

  @override
  Future<Result<ProductsResponseModels>> getAllProducts(
    String? categoryId,
  ) async {
    return await executeApi(() async {
      final response = await _apiClient.getAllProducts(categoryId);
      return response;
    });
  }
}
