import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/core/shared/entities/product_item_entity.dart';
import 'package:elevate_flower_app/features/occasions/domain/entities/occasion_card_entity.dart';

abstract class OccasionsRepository {
  Future<Result<List<OccasionCardEntity>>> getOccasions();
  Future<Result<List<ProductItemEntity>>> getOccasionFlowers(String occasionId);
}