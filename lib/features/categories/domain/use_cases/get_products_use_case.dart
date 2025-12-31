import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/categories/domain/entities/product_entity.dart';
import 'package:elevate_flower_app/features/categories/domain/repositories/categories_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetProductsUseCase {
  final CategoriesRepository repository;

  GetProductsUseCase({required this.repository});

  /// Execute the use case
  Future<Result<List<ProductEntity>>> execute() async {
    return await repository.getProducts();
  }

  /// Shorthand call method
  Future<Result<List<ProductEntity>>> call() => execute();
}