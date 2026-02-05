import '../../../../../core/config/base_state/base_state.dart';
import '../../../../../core/shared/entities/product_item_entity.dart';
import '../../../domain/use_cases/get_categories_use_case.dart';
import '../../../domain/use_cases/get_products_use_case.dart';
import 'categories_events.dart';
import 'categories_states.dart';
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
void _safeEmit(CategoriesStates newState) {
    if (!isClosed) {
      emit(newState);
    }
  }
  Future<void> _getCategories() async {
   _safeEmit(
      state.copyWith(
        categoriesState: const BaseState.loading(),
        productsState: state.productsOfCategory,
      ),
    );

    final result = await getCategoriesUseCase.call();

    result.when(
      success: (categories) {
        _safeEmit(
          state.copyWith(
            categoriesState: BaseState.success(categories),
            productsState: state.productsOfCategory,
          ),
        );
      },
      error: (exception) {
        _safeEmit(
          state.copyWith(
            categoriesState: BaseState.error(exception),
            productsState: state.productsOfCategory,
          ),
        );
      },
    );
  }

  Future<void> _getProducts(String categoryId) async {
    _safeEmit(
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

        _safeEmit(
          state.copyWith(
            categoriesState: state.category,
            productsState: BaseState.success(productItems),
          ),
        );
      },
      error: (exception) {
        _safeEmit(
          state.copyWith(
            categoriesState: state.category,
            productsState: BaseState.error(exception),
          ),
        );
      },
    );
  }

  Future<void> _getAllData() async {
    _safeEmit(
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

            _safeEmit(
              state.copyWith(
                categoriesState: BaseState.success(categories),
                productsState: BaseState.success(productItems),
              ),
            );
          },
          error: (exception) {
            _safeEmit(
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

            _safeEmit(
              state.copyWith(
                categoriesState: BaseState.error(exception),
                productsState: BaseState.success(productItems),
              ),
            );
          },
          error: (productsException) {
            _safeEmit(
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
