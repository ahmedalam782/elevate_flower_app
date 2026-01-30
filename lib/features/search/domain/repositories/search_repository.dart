import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/core/shared/entities/product_item_entity.dart';
import 'package:elevate_flower_app/features/search/domain/entities/search_params.dart';

abstract class SearchRepository {
  Future<Result<List<ProductItemEntity>>> searchProducts(SearchParams params);
}
