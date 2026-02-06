import '../../../../core/config/base_response/result.dart';
import '../../../../core/shared/entities/product_item_entity.dart';
import '../entities/search_params.dart';
import '../repositories/search_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class SearchProductsUseCase {
  final SearchRepository _repository;

  SearchProductsUseCase(this._repository);

  Future<Result<List<ProductItemEntity>>> call(SearchParams params) {
    return _repository.searchProducts(params);
  }
}
