import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/core/shared/entities/product_item_entity.dart';
import 'package:elevate_flower_app/features/occasions/domain/repositories/occasions_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetProductsByOccasionUseCase {
  final OccasionsRepository _occasionsRepository;

  GetProductsByOccasionUseCase(this._occasionsRepository);

  Future<Result<List<ProductItemEntity>>> call(String occasionId) {
    return _occasionsRepository.getOccasionFlowers(occasionId);
  }
}