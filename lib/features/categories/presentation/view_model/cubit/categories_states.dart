import 'package:elevate_flower_app/core/config/base_state/base_state.dart';
import 'package:elevate_flower_app/core/shared/entities/product_item_entity.dart';
import 'package:elevate_flower_app/features/categories/domain/entities/category_entity.dart';
import 'package:equatable/equatable.dart';

class CategoriesStates extends Equatable {
  final BaseState<List<CategoryEntity>> category;
  final BaseState<List<ProductItemEntity>> productsOfCategory;

  const CategoriesStates({
    this.category = const BaseState.initial(),
    this.productsOfCategory = const BaseState.initial(),
  });

  @override
  List<Object> get props => [category, productsOfCategory];

  CategoriesStates copyWith({
    BaseState<List<CategoryEntity>>? categoriesState,
    BaseState<List<ProductItemEntity>>? productsState,
  }) =>
      CategoriesStates(
        category: categoriesState ?? category,
        productsOfCategory: productsState ?? productsOfCategory,
      );
}