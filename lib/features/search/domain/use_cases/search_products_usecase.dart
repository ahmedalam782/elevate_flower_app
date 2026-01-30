import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/core/shared/entities/product_item_entity.dart';
import 'package:elevate_flower_app/features/search/domain/entities/search_params.dart';
import 'package:elevate_flower_app/features/search/domain/repositories/search_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class SearchProductsUseCase {
  final SearchRepository _repository;

  SearchProductsUseCase(this._repository);

  Future<Result<List<ProductItemEntity>>> call(SearchParams params) {
    return _repository.searchProducts(params);
  }
}
