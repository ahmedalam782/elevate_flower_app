import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/most_seller/domain/entities/best_seller_page_entity.dart';

abstract class BestSellerRepository {
  Future<Result<BestSellerPageEntity>> getBestSellerProducts();
}
