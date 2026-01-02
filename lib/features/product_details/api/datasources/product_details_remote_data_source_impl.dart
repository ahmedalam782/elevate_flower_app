// TODO: api Product_detailsRemoteDataSourceImpl

import 'package:elevate_flower_app/core/config/api/api_executer.dart';
import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/product_details/api/api_client/product_details_api_client.dart';
import 'package:elevate_flower_app/features/product_details/data/datasources/product_details_remote_data_source_contract.dart';
import 'package:elevate_flower_app/features/product_details/data/models/specefic_product_response/specefic_product_response.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProductDetailsRemoteDataSourceContract)
class ProductDetailsRemoteDataSourceImpl
    implements ProductDetailsRemoteDataSourceContract {
  final ProductDetailsApiClient _apiClient;

  ProductDetailsRemoteDataSourceImpl(this._apiClient);
  @override
  Future<Result<SpeceficProductResponse>> getSpeceficProduct(
    String productId,
  ) async {
    return await executeApi<SpeceficProductResponse>(() async {
      final response = await _apiClient.getSpeceficProduct(productId);
      return response;
    });

    // print("INSIDE ProductDetailsRemoteDataSourceImpl");
    // return await executeApi<SpeceficProductResponse>(
    //   () => _apiClient.getSpeceficProduct(productId),
    // );
  }
}
