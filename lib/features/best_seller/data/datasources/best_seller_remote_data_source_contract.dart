import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/best_seller/data/models/best_seller_response_model.dart';

abstract class BestSellerRemoteDataSourceContract {
  Future<Result<BestSellerResponseModel>> getBestSellerProducts();
}
