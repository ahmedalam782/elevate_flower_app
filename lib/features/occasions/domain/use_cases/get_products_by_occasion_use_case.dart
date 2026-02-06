import '../../../../core/config/base_response/result.dart';
import '../../../../core/shared/entities/product_item_entity.dart';
import '../repositories/occasions_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetProductsByOccasionUseCase {
  final OccasionsRepository _occasionsRepository;

  GetProductsByOccasionUseCase(this._occasionsRepository);

  Future<Result<List<ProductItemEntity>>> call(String occasionId) {
    return _occasionsRepository.getOccasionFlowers(occasionId);
  }
}