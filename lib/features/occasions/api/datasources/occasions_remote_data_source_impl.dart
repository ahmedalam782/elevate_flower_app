import '../../../../core/config/api/api_executer.dart';
import '../../../../core/config/base_response/result.dart';
import '../api_client/occasions_api_client.dart';
import '../../data/datasources/occasions_remote_data_source_contract.dart';
import '../../data/models/occasions_model.dart';
import '../../data/models/product_model.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: OccasionsRemoteDataSourceContract)
class OccasionsRemoteDataSourceImpl
    implements OccasionsRemoteDataSourceContract {
  final OccasionsApiClient occasionsApiClient;
  OccasionsRemoteDataSourceImpl(this.occasionsApiClient);

  @override
  Future<Result<OccasionModel>> getAllOccasions() async {
    return await executeApi(() => occasionsApiClient.getOccasions());
  }

  @override
  Future<Result<ProductModel>> getOccasionFlowers(String occasionId) async {
    return await executeApi(
      () => occasionsApiClient.getOccasionFlowers(occasionId),
    );
  }
}
