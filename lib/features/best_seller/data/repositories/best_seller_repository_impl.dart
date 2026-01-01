import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/best_seller/data/datasources/best_seller_remote_data_source_contract.dart';
import 'package:elevate_flower_app/features/best_seller/domain/entities/best_seller_page_entity.dart';
import 'package:elevate_flower_app/features/best_seller/domain/repositories/best_seller_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: BestSellerRepository)
class BestSellerRepositoryImpl extends BestSellerRepository {
  BestSellerRepositoryImpl(this._repoDataSource);
  final BestSellerRemoteDataSourceContract _repoDataSource;

  @override
  Future<Result<BestSellerPageEntity>> getBestSellerProducts() async {
    final result = await _repoDataSource.getBestSellerProducts();
    return result.when(
      success: (data) {
        final dataMapped = data?.toEntity();
        return Success(data: dataMapped);
      },
      error: (exception) {
        return Error(exception: exception);
      },
    );
  }
}
