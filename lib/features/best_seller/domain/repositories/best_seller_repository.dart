import '../../../../core/config/base_response/result.dart';
import '../entities/best_seller_page_entity.dart';

abstract class BestSellerRepository {
  Future<Result<BestSellerPageEntity>> getBestSellerProducts();
}
