// TODO: data CartRemoteDataSourceContract

import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/cart/data/models/cart_response.dart';
import 'package:elevate_flower_app/features/cart/data/models/post/cart_product_post_data.dart';

abstract class CartRemoteDataSourceContract {
  Future<Result<CartResponse>> getCartData();
  Future<Result<void>> addProductToCart(CartProductPostData data);
}
