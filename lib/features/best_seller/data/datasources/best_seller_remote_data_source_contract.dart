import '../../../../core/config/base_response/result.dart';
import '../models/best_seller_response_model.dart';

abstract class BestSellerRemoteDataSourceContract {
  Future<Result<BestSellerResponseModel>> getBestSellerProducts();
}
