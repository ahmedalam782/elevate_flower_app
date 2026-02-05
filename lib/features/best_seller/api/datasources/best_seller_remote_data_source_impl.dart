import '../../../../core/config/api/api_executer.dart';
import '../../../../core/config/base_response/result.dart';
import '../api_client/best_seller_api_client.dart';
import '../../data/datasources/best_seller_remote_data_source_contract.dart';
import '../../data/models/best_seller_response_model.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: BestSellerRemoteDataSourceContract)
class BestSellerRemoteDataSourceImpl
    implements BestSellerRemoteDataSourceContract {
  const BestSellerRemoteDataSourceImpl(this._apiClient);
  final BestSellerApiClient _apiClient;
  @override
  Future<Result<BestSellerResponseModel>> getBestSellerProducts() async{
    return await executeApi<BestSellerResponseModel>(
      () => _apiClient.getBestSellerProducts(),
    );
  }
}
