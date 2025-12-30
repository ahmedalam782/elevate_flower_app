import 'package:elevate_flower_app/core/config/api/api_executer.dart';
import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/most_seller/api/api_client/best_seller_api_client.dart';
import 'package:elevate_flower_app/features/most_seller/data/datasources/best_seller_remote_data_source_contract.dart';
import 'package:elevate_flower_app/features/most_seller/data/models/best_seller_response_model.dart';

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
