import '../../../../core/config/base_response/result.dart';
import '../entities/occasion_card_entity.dart';
import '../repositories/occasions_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetOccasionsUseCase {
  final OccasionsRepository _occasionsRepository;

  GetOccasionsUseCase(this._occasionsRepository);

  Future<Result<List<OccasionCardEntity>>> call() {
    return _occasionsRepository.getOccasions();
  }
}