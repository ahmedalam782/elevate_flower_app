import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/occasions/data/datasources/occasions_remote_data_source_contract.dart';
import 'package:elevate_flower_app/features/occasions/data/models/occasions_mapper.dart';
import 'package:elevate_flower_app/features/occasions/data/models/product_mapper.dart';
import 'package:elevate_flower_app/features/occasions/domain/entities/occasion_card_entity.dart';
import 'package:elevate_flower_app/features/occasions/domain/entities/product_card_entity.dart';
import 'package:elevate_flower_app/features/occasions/domain/repositories/occasions_repository.dart';
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
  Future<Result<List<ProductCardEntity>>> getOccasionFlowers(
    String occasionId,
  ) async {
    final productModels = await _remoteDataSource.getOccasionFlowers(
      occasionId,
    );
    return productModels.when(
      success: (data) {
        return Success<List<ProductCardEntity>>(
          data: (data?.products ?? [])
              .map((model) => model.toEntity())
              .toList(),
        );
      },
      error: (exception) {
        return Error<List<ProductCardEntity>>(exception: exception);
      },
    );
  }
}
