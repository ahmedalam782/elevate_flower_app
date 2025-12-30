import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/categories/domain/entities/category_entity.dart';

/// Repository contract for Categories
/// This is the interface that the domain layer uses
/// The data layer will implement this interface
abstract class CategoriesRepository {
  /// Fetches categories from the data source
  /// Returns a Result containing either CategoryEntity or an Exception
  Future<Result<List<CategoryEntity>>> getCategories();
}