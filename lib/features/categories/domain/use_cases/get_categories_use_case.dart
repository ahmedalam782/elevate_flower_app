import '../../../../core/config/base_response/result.dart';
import '../entities/category_entity.dart';
import '../repositories/categories_repository.dart';
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