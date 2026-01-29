import 'package:elevate_flower_app/core/config/base_state/base_state.dart';
// Refreshed
import 'package:elevate_flower_app/core/shared/entities/product_item_entity.dart';

class SearchStates {
  SearchStates({
    this.searchState = const BaseState.initial(),
    this.products = const [],
    this.isLastPage = false,
  });

  final BaseState<List<ProductItemEntity>> searchState;
  final List<ProductItemEntity> products;
  final bool isLastPage;

  SearchStates copyWith({
    BaseState<List<ProductItemEntity>>? searchState,
    List<ProductItemEntity>? products,
    bool? isLastPage,
  }) {
    return SearchStates(
      searchState: searchState ?? this.searchState,
      products: products ?? this.products,
      isLastPage: isLastPage ?? this.isLastPage,
    );
  }
}
