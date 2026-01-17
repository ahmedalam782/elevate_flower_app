import 'package:elevate_flower_app/core/config/api/api_executer.dart';
import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/cart/api/api_client/cart_api_client.dart';
import 'package:elevate_flower_app/features/cart/data/datasources/cart_remote_data_source_contract.dart';
import 'package:elevate_flower_app/features/cart/data/models/cart_response.dart';
import 'package:elevate_flower_app/features/cart/data/models/post/cart_product_post_data.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CartRemoteDataSourceContract)
class CartRemoteDataSourceImpl implements CartRemoteDataSourceContract {
  final CartApiClient cartApiClient;

  CartRemoteDataSourceImpl({required this.cartApiClient});
  @override
  Future<Result<CartResponse>> getCartData() async {
    return await executeApi<CartResponse>(() async {
      final response = await cartApiClient.getCartData();
      return response;
    });
  }

  @override
  Future<Result<void>> addProductToCart(CartProductPostData data) async {
    return await executeApi<void>(() async {
      final response = await cartApiClient.addItemToCart(data);
      return response;
    });
  }

  @override
  Future<Result<void>> removeProductFromCart(String productId) async {
    return await executeApi<void>(() async {
      final response = await cartApiClient.removeItemFromCart(productId);
      return response;
    });
  }
}
