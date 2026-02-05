import '../../../../core/config/base_response/result.dart';
import '../entities/best_seller_page_entity.dart';
import '../repositories/best_seller_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetBestSellerProductsUseCase {
  GetBestSellerProductsUseCase(this._repo);
  final BestSellerRepository _repo;

  Future<Result<BestSellerPageEntity>> call() {
    return _repo.getBestSellerProducts();
  }
}
