import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/categories/domain/entities/category_entity.dart';
import 'package:elevate_flower_app/features/categories/domain/repositories/categories_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetCategoriesUseCase {
  final CategoriesRepository _repository;

  GetCategoriesUseCase({required CategoriesRepository repository})
      : _repository = repository;

  Future<Result<List<CategoryEntity>>> call() async {
    return await _repository.getAllCategories();
  }
}