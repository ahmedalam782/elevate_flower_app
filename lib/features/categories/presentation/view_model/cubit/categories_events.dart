/// Events for Categories Feature
sealed class CategoriesEvents {}

/// Event to fetch all categories
class GetCategoriesEvent extends CategoriesEvents {}

/// Event to fetch all products
class GetProductsEvent extends CategoriesEvents {}

/// Event to fetch both categories and products
class GetAllDataEvent extends CategoriesEvents {}

/// Event to filter products by category
class FilterProductsByCategoryEvent extends CategoriesEvents {
  final String categoryId;

  FilterProductsByCategoryEvent(this.categoryId);
}