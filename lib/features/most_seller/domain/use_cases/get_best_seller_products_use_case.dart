import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/most_seller/domain/entities/best_seller_page_entity.dart';
import 'package:elevate_flower_app/features/most_seller/domain/repositories/best_seller_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetBestSellerProductsUseCase {
  GetBestSellerProductsUseCase(this._repo);
  final BestSellerRepository _repo;

  Future<Result<BestSellerPageEntity>> call() {
    return _repo.getBestSellerProducts();
  }
}
