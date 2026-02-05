import '../../../../core/config/base_response/result.dart';
import '../../../../core/shared/entities/product_item_entity.dart';
import '../entities/search_params.dart';

abstract class SearchRepository {
  Future<Result<List<ProductItemEntity>>> searchProducts(SearchParams params);
}
