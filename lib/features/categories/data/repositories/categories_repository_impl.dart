import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/categories/data/datasources/categories_remote_data_source_contract.dart';
import 'package:elevate_flower_app/features/categories/data/models/category_model/category_mapper.dart';
import 'package:elevate_flower_app/features/categories/data/models/product_model/product_mapper.dart';
import 'package:elevate_flower_app/features/categories/domain/entities/category_entity.dart';
import 'package:elevate_flower_app/features/categories/domain/entities/product_entity.dart';
import 'package:elevate_flower_app/features/categories/domain/repositories/categories_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: CategoriesRepository)
class CategoriesRepositoryImpl implements CategoriesRepository {
  final CategoriesRemoteDataSourceContract _remoteDataSource;

  CategoriesRepositoryImpl({
    required CategoriesRemoteDataSourceContract remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<Result<List<CategoryEntity>>> getAllCategories() async {
    final result = await _remoteDataSource.getAllCategories();

    return result.when(
      success: (data) {
        final categories = data?.toEntities() ?? [];
        return Success(data: categories);
      },
      error: (exception) {
        return Error(exception: exception);
      },
    );
  }

  @override
  Future<Result<List<ProductEntity>>> getAllproducts(String? categoryId) async {
    final result = await _remoteDataSource.getAllProducts(categoryId);

    return result.when(
      success: (data) {
        final products = data?.toEntities() ?? [];
        return Success(data: products);
      },
      error: (exception) {
        return Error(exception: exception);
      },
    );
  }
}
