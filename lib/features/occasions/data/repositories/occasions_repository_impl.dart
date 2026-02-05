import '../../../../core/config/base_response/result.dart';
import '../../../../core/shared/entities/product_item_entity.dart';
import '../datasources/occasions_remote_data_source_contract.dart';
import '../models/occasions_mapper.dart';
import '../models/product_mapper.dart';
import '../../domain/entities/occasion_card_entity.dart';
import '../../domain/repositories/occasions_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: OccasionsRepository)
class OccasionsRepositoryImpl extends OccasionsRepository {
  final OccasionsRemoteDataSourceContract _remoteDataSource;

  OccasionsRepositoryImpl(this._remoteDataSource);

  @override
  Future<Result<List<OccasionCardEntity>>> getOccasions() async {
    final occasionModels = await _remoteDataSource.getAllOccasions();
    return occasionModels.when(
      success: (data) {
        return Success<List<OccasionCardEntity>>(
          data: (data?.occasions ?? [])
              .map((model) => model.toEntity())
              .toList(),
        );
      },
      error: (exception) {
        return Error<List<OccasionCardEntity>>(exception: exception);
      },
    );
  }

  @override
  Future<Result<List<ProductItemEntity>>> getOccasionFlowers(
    String occasionId,
  ) async {
    final productModels = await _remoteDataSource.getOccasionFlowers(
      occasionId,
    );
    return productModels.when(
      success: (data) {
        return Success<List<ProductItemEntity>>(
          data: (data?.products ?? [])
              .map((model) => model.toEntity())
              .toList(),
        );
      },
      error: (exception) {
        return Error<List<ProductItemEntity>>(exception: exception);
      },
    );
  }
}
