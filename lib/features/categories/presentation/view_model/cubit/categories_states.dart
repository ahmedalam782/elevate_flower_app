import 'package:elevate_flower_app/core/config/base_state/base_state.dart';
import 'package:elevate_flower_app/features/categories/domain/entities/category_entity.dart';
import 'package:elevate_flower_app/features/categories/domain/entities/product_entity.dart';

/// State for Categories Feature
class CategoriesStates {
  final BaseState<List<CategoryEntity>> categoriesState;
  final BaseState<List<ProductEntity>> productsState;
  final String? selectedCategoryId;

  const CategoriesStates({
    required this.categoriesState,
    required this.productsState,
    this.selectedCategoryId,
  });

  /// Initial state
  factory CategoriesStates.initial() {
    return const CategoriesStates(
      categoriesState: BaseState.initial(),
      productsState: BaseState.initial(),
      selectedCategoryId: null,
    );
  }

  /// Copy with method for immutability
  CategoriesStates copyWith({
    BaseState<List<CategoryEntity>>? categoriesState,
    BaseState<List<ProductEntity>>? productsState,
    String? selectedCategoryId,
  }) {
    return CategoriesStates(
      categoriesState: categoriesState ?? this.categoriesState,
      productsState: productsState ?? this.productsState,
      selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
    );
  }

  /// Get filtered products by selected category
  List<ProductEntity> get filteredProducts {
    if (selectedCategoryId == null) {
      return productsState.data ?? [];
    }

    return productsState.data
            ?.where((product) => product.category == selectedCategoryId)
            .toList() ??
        [];
  }
}