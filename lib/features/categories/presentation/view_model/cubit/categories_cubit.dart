import 'dart:developer';

import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/core/config/base_state/base_cubit.dart';
import 'package:elevate_flower_app/core/config/base_state/base_state.dart';
import 'package:elevate_flower_app/features/categories/domain/entities/category_entity.dart';
import 'package:elevate_flower_app/features/categories/domain/entities/product_entity.dart';
import 'package:elevate_flower_app/features/categories/domain/use_cases/get_categories_use_case.dart';
import 'package:elevate_flower_app/features/categories/domain/use_cases/get_products_use_case.dart';
import 'package:elevate_flower_app/features/categories/presentation/view_model/cubit/categories_events.dart';
import 'package:elevate_flower_app/features/categories/presentation/view_model/cubit/categories_states.dart';
import 'package:injectable/injectable.dart';

@injectable
class CategoriesCubit extends BaseCubit<CategoriesStates, CategoriesEvents, void> {
  final GetCategoriesUseCase _getCategoriesUseCase;
  final GetProductsUseCase _getProductsUseCase;

  CategoriesCubit(
    this._getCategoriesUseCase,
    this._getProductsUseCase,
  ) : super(CategoriesStates.initial());

  // ================== EVENTS ==================

  @override
  Future<void> doAction(CategoriesEvents event) async {
    switch (event) {
      case GetCategoriesEvent():
        await _getCategories();
        break;

      case GetProductsEvent():
        await _getProducts();
        break;

      case GetAllDataEvent():
        await _getAllData();
        break;

      case FilterProductsByCategoryEvent():
        _filterProductsByCategory(event.categoryId);
        break;
    }
  }

  // ================== CATEGORIES ==================

  Future<void> _getCategories() async {
    emit(
      state.copyWith(
        categoriesState: const BaseState.loading(),
      ),
    );

    Result<List<CategoryEntity>> result = await _getCategoriesUseCase();

    switch (result) {
      case Success<List<CategoryEntity>>():
        emit(
          state.copyWith(
            categoriesState: BaseState.success(result.data ?? []),
          ),
        );

      case Error<List<CategoryEntity>>():
        log('Categories Error: ${result.exception}');
        emit(
          state.copyWith(
            categoriesState: BaseState.error(result.exception),
          ),
        );
    }
  }

  // ================== PRODUCTS ==================

  Future<void> _getProducts() async {
    emit(
      state.copyWith(
        productsState: const BaseState.loading(),
      ),
    );

    Result<List<ProductEntity>> result = await _getProductsUseCase();

    switch (result) {
      case Success<List<ProductEntity>>():
        emit(
          state.copyWith(
            productsState: BaseState.success(result.data ?? []),
          ),
        );

      case Error<List<ProductEntity>>():
        log('Products Error: ${result.exception}');
        emit(
          state.copyWith(
            productsState: BaseState.error(result.exception),
          ),
        );
    }
  }

  // ================== ALL DATA ==================

  Future<void> _getAllData() async {
    emit(
      state.copyWith(
        categoriesState: const BaseState.loading(),
        productsState: const BaseState.loading(),
      ),
    );

    await Future.wait([
      _getCategories(),
      _getProducts(),
    ]);
  }

  // ================== FILTER ==================

  void _filterProductsByCategory(String categoryId) {
    emit(
      state.copyWith(
        selectedCategoryId: categoryId,
      ),
    );
  }

  // ================== CLEAR FILTER ==================

  void clearFilter() {
    emit(
      state.copyWith(
        selectedCategoryId: null,
      ),
    );
  }
}