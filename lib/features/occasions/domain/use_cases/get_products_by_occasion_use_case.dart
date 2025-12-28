import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/occasions/domain/entities/product_card_entity.dart';
import 'package:elevate_flower_app/features/occasions/domain/repositories/occasions_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetProductsByOccasionUseCase {
  final OccasionsRepository _occasionsRepository;

  GetProductsByOccasionUseCase(this._occasionsRepository);

  Future<Result<List<ProductCardEntity>>> call(String occasionId) {
    return _occasionsRepository.getOccasionFlowers(occasionId);
  }
}