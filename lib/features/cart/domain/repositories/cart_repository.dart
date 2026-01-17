// TODO: domain CartRepository

import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/cart/domain/entities/cart_entity.dart';

abstract class CartRepository {
  Future<Result<CartEntity>> getCartData();
}
