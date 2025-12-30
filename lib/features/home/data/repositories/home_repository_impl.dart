import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/home/data/datasources/home_remote_data_source_contract.dart';
import 'package:elevate_flower_app/features/home/data/models/home_response.dart';
import 'package:elevate_flower_app/features/home/domain/entities/home_entity.dart';
import 'package:elevate_flower_app/features/home/domain/repositories/home_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: HomeRepository)
class HomeRepoImpl extends HomeRepository {
   final HomeRemoteDataSourceContract homeRemoteDataSourceContract;
  HomeRepoImpl(this.homeRemoteDataSourceContract);

  @override
  Future<Result<HomeEntity>> getHomeData() async {
    Result<HomeResponse> response = await homeRemoteDataSourceContract
        .getHomeData();

    return response.when(
      success: (homeResponse) {
        HomeEntity homeEntity = HomeEntity(
          products:
              homeResponse?.products.map((e) => e.toDomain()).toList() ?? [],

          categories:
              homeResponse?.categories.map((e) => e.toDomain()).toList() ?? [],

          bestSeller:
              homeResponse?.bestSeller.map((e) => e.toDomain()).toList() ?? [],

          occasions:
              homeResponse?.occasions.map((e) => e.toDomain()).toList() ?? [],
        );
        return Success(data: homeEntity);
      },
      error: (e) {
        return Error(exception: Exception(e.toString()));
      },
    );
  }
}
