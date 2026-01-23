// TODO: data Product_detailsRepositoryImpl
import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/product_details/data/datasources/product_details_remote_data_source_contract.dart';
import 'package:elevate_flower_app/features/product_details/data/models/specefic_product_response/specefic_product_response.dart';
import 'package:elevate_flower_app/features/product_details/domain/entities/specefic_product_entity.dart';
import 'package:elevate_flower_app/features/product_details/domain/repositories/product_details_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProductDetailsRepository)
class ProductDetailsRepositoryImpl implements ProductDetailsRepository {
  final ProductDetailsRemoteDataSourceContract
  productDetailsRemoteDataSourceContract;

  ProductDetailsRepositoryImpl({
    required this.productDetailsRemoteDataSourceContract,
  });
  @override
  Future<Result<SpeceficProductEntity>> getSpeceficProduct(
    String productId,
  ) async {
    final response = await productDetailsRemoteDataSourceContract
        .getSpeceficProduct(productId);
    switch (response) {
      case Success<SpeceficProductResponse>():
        return Success<SpeceficProductEntity>(
          data: response.data?.product?.toSpeceficProductEntity(),
        );
      case Error<SpeceficProductResponse>():
        return Error<SpeceficProductEntity>(exception: response.exception);
    }
  }
}
