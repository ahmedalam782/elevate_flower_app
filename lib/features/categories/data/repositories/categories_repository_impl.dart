import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/categories/data/datasources/categories_remote_data_source_contract.dart';
import 'package:elevate_flower_app/features/categories/data/models/category_mapper.dart'; // 👈 Import الـ mapper
import 'package:elevate_flower_app/features/categories/domain/entities/category_entity.dart';
import 'package:elevate_flower_app/features/categories/domain/repositories/categories_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: CategoriesRepository)
class CategoriesRepositoryImpl implements CategoriesRepository {
  final CategoriesRemoteDataSourceContract remoteDataSource;

  CategoriesRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Result<List<CategoryEntity>>> getCategories() async {
    final result = await remoteDataSource.getCategories();

    return result.when(
      success: (data) {
        // 👇 استخدم الـ extension
        final categories = data?.toEntities() ?? [];
        return Success(data: categories);
      },
      error: (exception) {
        return Error(exception: exception);
      },
    );
  }
}