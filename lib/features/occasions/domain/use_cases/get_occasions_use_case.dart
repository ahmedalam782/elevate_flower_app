import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/occasions/domain/entities/occasion_card_entity.dart';
import 'package:elevate_flower_app/features/occasions/domain/repositories/occasions_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetOccasionsUseCase {
  final OccasionsRepository _occasionsRepository;

  GetOccasionsUseCase(this._occasionsRepository);

  Future<Result<List<OccasionCardEntity>>> call() {
    return _occasionsRepository.getOccasions();
  }
}