import '../../../../core/config/base_response/result.dart';
import '../models/occasions_model.dart';
import '../models/product_model.dart';

abstract class OccasionsRemoteDataSourceContract {
  Future<Result<OccasionModel>> getAllOccasions();
  Future<Result<ProductModel>> getOccasionFlowers(String occasionId);
}