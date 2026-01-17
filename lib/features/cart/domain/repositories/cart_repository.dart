// TODO: domain CartRepository

import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/cart/data/models/post/cart_product_post_data.dart';
import 'package:elevate_flower_app/features/cart/domain/entities/cart_entity.dart';

abstract class CartRepository {
  Future<Result<CartEntity>> getCartData();
  Future<Result<void>> addProductToCart(CartProductPostData data);
}
