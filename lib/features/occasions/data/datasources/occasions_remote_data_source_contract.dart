import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/occasions/data/models/occasions_model.dart';
import 'package:elevate_flower_app/features/occasions/data/models/product_model.dart';

abstract class OccasionsRemoteDataSourceContract {
  Future<Result<OccasionModel>> getAllOccasions();
  Future<Result<ProductModel>> getOccasionFlowers(String occasionId);
}