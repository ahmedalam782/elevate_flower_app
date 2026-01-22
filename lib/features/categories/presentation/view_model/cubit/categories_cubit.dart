import 'package:elevate_flower_app/core/config/base_state/base_state.dart';
import 'package:elevate_flower_app/core/shared/entities/product_item_entity.dart';
import 'package:elevate_flower_app/features/categories/domain/use_cases/get_categories_use_case.dart';
import 'package:elevate_flower_app/features/categories/domain/use_cases/get_products_use_case.dart';
import 'package:elevate_flower_app/features/categories/presentation/view_model/cubit/categories_events.dart';
import 'package:elevate_flower_app/features/categories/presentation/view_model/cubit/categories_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class CategoriesCubit extends Cubit<CategoriesStates> {
  final GetCategoriesUseCase getCategoriesUseCase;
  final GetProductsUseCase getProductsUseCase;

  CategoriesCubit({
    required this.getCategoriesUseCase,
    required this.getProductsUseCase,
  }) : super(const CategoriesStates());

  void onEvent(CategoriesEvents event) {
    switch (event) {
      case GetCategoriesEvent():
        _getCategories();
        break;
      case GetProductsEvent():
        _getProducts(event.categoryId);
        break;
      case GetAllDataEvent():
        _getAllData();
        break;
    }
  }

  Future<void> _getCategories() async {
    emit(
      state.copyWith(
        categoriesState: const BaseState.loading(),
        productsState: state.productsOfCategory,
      ),
    );

    final result = await getCategoriesUseCase.call();

    result.when(
      success: (categories) {
        emit(
          state.copyWith(
            categoriesState: BaseState.success(categories),
            productsState: state.productsOfCategory,
          ),
        );
      },
      error: (exception) {
        emit(
          state.copyWith(
            categoriesState: BaseState.error(exception),
            productsState: state.productsOfCategory,
          ),
        );
      },
    );
  }

  Future<void> _getProducts(String categoryId) async {
    emit(
      state.copyWith(
        categoriesState: state.category,
        productsState: const BaseState.loading(),
      ),
    );

    final result = await getProductsUseCase.call(
      categoryId.isEmpty ? null : categoryId,
    );

    result.when(
      success: (products) {
        // Map ProductEntity to ProductItemEntity
        final productItems =
            products
                ?.map(
                  (product) => ProductItemEntity(
                    id: product.id,
                    name: product.title,
                    description: product.description,
                    price: product.price,
                    priceAfterDiscount: product.priceAfterDiscount,
                    imageUrl: product.imgCover,
                  ),
                )
                .toList() ??
            [];

        emit(
          state.copyWith(
            categoriesState: state.category,
            productsState: BaseState.success(productItems),
          ),
        );
      },
      error: (exception) {
        emit(
          state.copyWith(
            categoriesState: state.category,
            productsState: BaseState.error(exception),
          ),
        );
      },
    );
  }

  Future<void> _getAllData() async {
    emit(
      state.copyWith(
        categoriesState: const BaseState.loading(),
        productsState: const BaseState.loading(),
      ),
    );

    final categoriesResult = await getCategoriesUseCase.call();
    final productsResult = await getProductsUseCase.call(null);

    categoriesResult.when(
      success: (categories) {
        productsResult.when(
          success: (products) {
            // Map ProductEntity to ProductItemEntity
            final productItems =
                products
                    ?.map(
                      (product) => ProductItemEntity(
                        id: product.id,
                        name: product.title,
                        description: product.description,
                        price: product.price,
                        priceAfterDiscount: product.priceAfterDiscount,
                        imageUrl: product.imgCover,
                      ),
                    )
                    .toList() ??
                [];

            emit(
              state.copyWith(
                categoriesState: BaseState.success(categories),
                productsState: BaseState.success(productItems),
              ),
            );
          },
          error: (exception) {
            emit(
              state.copyWith(
                categoriesState: BaseState.success(categories),
                productsState: BaseState.error(exception),
              ),
            );
          },
        );
      },
      error: (exception) {
        productsResult.when(
          success: (products) {
            // Map ProductEntity to ProductItemEntity
            final productItems =
                products
                    ?.map(
                      (product) => ProductItemEntity(
                        id: product.id,
                        name: product.title,
                        description: product.description,
                        price: product.price,
                        priceAfterDiscount: product.priceAfterDiscount,
                        imageUrl: product.imgCover,
                      ),
                    )
                    .toList() ??
                [];

            emit(
              state.copyWith(
                categoriesState: BaseState.error(exception),
                productsState: BaseState.success(productItems),
              ),
            );
          },
          error: (productsException) {
            emit(
              state.copyWith(
                categoriesState: BaseState.error(exception),
                productsState: BaseState.error(productsException),
              ),
            );
          },
        );
      },
    );
  }

  @override
  void emit(CategoriesStates state) {
    if (isClosed) return;
    super.emit(state);
  }
}
