/// Events for Categories Feature
sealed class CategoriesEvents {}

/// Event to fetch all categories
class GetCategoriesEvent extends CategoriesEvents {}

/// Event to fetch products by category
class GetProductsEvent extends CategoriesEvents {
  final String categoryId;

  GetProductsEvent({this.categoryId = ''});
}

/// Event to fetch both categories and products
class GetAllDataEvent extends CategoriesEvents {}
