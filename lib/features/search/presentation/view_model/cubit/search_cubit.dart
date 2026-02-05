import '../../../../../core/config/base_state/base_state.dart';
import '../../../../../core/shared/entities/product_item_entity.dart';
import '../../../domain/entities/search_params.dart';
import '../../../domain/use_cases/search_products_usecase.dart';
import 'search_events.dart';
import 'search_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class SearchCubit extends Cubit<SearchStates> {
  final SearchProductsUseCase _searchProductsUseCase;

  SearchCubit(this._searchProductsUseCase) : super(const SearchStates());

  SearchParams _currentParams = const SearchParams(keyword: '');
  List<ProductItemEntity> _currentProducts = [];

  Future<void> doIntent(SearchEvents event) async {
    event.when(search: _search, loadMore: _loadMore);
  }

  Future<void> _search(String keyword, int limit) async {
    if (keyword.trim().isEmpty) {
      emit(const SearchStates());
      return;
    }

    _currentParams = SearchParams(keyword: keyword, page: 1, limit: limit);
    _currentProducts = [];

    emit(
      state.copyWith(searchState: const BaseState.loading(), isLastPage: false),
    );

    final result = await _searchProductsUseCase(_currentParams);

    result.when(
      success: (products) {
        if (products == null || products.isEmpty) {
          emit(
            state.copyWith(
              searchState: const BaseState.success([]),
              products: const [],
              isLastPage: true,
            ),
          );
        } else {
          _currentProducts = products;
          final isLast = products.length < _currentParams.limit;
          emit(
            state.copyWith(
              searchState: BaseState.success(List.from(_currentProducts)),
              products: List.from(_currentProducts),
              isLastPage: isLast,
            ),
          );
        }
      },
      error: (exception) {
        emit(state.copyWith(searchState: BaseState.error(exception)));
      },
    );
  }

  Future<void> _loadMore() async {
    if (state.isLastPage ||
        state.searchState.state == StateType.loading ||
        state.searchState.state == StateType.moreLoading) {
      return;
    }

    _currentParams = _currentParams.copyWith(page: _currentParams.page + 1);

    emit(
      state.copyWith(
        searchState: const BaseState.all(
          state: StateType.moreLoading,
          data: null,
          exception: null,
        ),
      ),
    );

    final result = await _searchProductsUseCase(_currentParams);

    result.when(
      success: (newProducts) {
        if (newProducts == null || newProducts.isEmpty) {
          emit(
            state.copyWith(
              searchState: BaseState.success(List.from(_currentProducts)),
              isLastPage: true,
            ),
          );
        } else {
          _currentProducts = List.from(_currentProducts)..addAll(newProducts);
          final isLast = newProducts.length < _currentParams.limit;
          emit(
            state.copyWith(
              searchState: BaseState.success(List.from(_currentProducts)),
              products: List.from(_currentProducts),
              isLastPage: isLast,
            ),
          );
        }
      },
      error: (exception) {
        // Revert page on error
        _currentParams = _currentParams.copyWith(page: _currentParams.page - 1);
        emit(
          state.copyWith(
            searchState: BaseState.success(List.from(_currentProducts)),
          ),
        );
      },
    );
  }
}
