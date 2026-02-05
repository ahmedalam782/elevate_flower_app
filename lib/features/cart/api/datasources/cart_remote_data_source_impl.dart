import '../../../../core/config/api/api_executer.dart';
import '../../../../core/config/base_response/result.dart';
import '../api_client/cart_api_client.dart';
import '../../data/datasources/cart_remote_data_source_contract.dart';
import '../../data/models/cart_response.dart';
import '../../data/models/post/cart_product_post_data.dart';
import '../../data/models/post/cart_update_data.dart';
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

  @override
  Future<Result<void>> clearUserCart() async {
    return await executeApi<void>(() async {
      final response = await cartApiClient.clearUserCart();
      return response;
    });
  }

  @override
  Future<Result<void>> updateCartQuantity(
    String id,
    CartUpdateDataModel data,
  ) async {
    return await executeApi<void>(() async {
      final response = await cartApiClient.updateItemInCart(id, data);
      return response;
    });
  }
}
