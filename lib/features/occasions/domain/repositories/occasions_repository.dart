import '../../../../core/config/base_response/result.dart';
import '../../../../core/shared/entities/product_item_entity.dart';
import '../entities/occasion_card_entity.dart';

abstract class OccasionsRepository {
  Future<Result<List<OccasionCardEntity>>> getOccasions();
  Future<Result<List<ProductItemEntity>>> getOccasionFlowers(String occasionId);
}