// TODO: data CartRemoteDataSourceContract

import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/cart/data/models/cart_response.dart';

abstract class CartRemoteDataSourceContract {
  Future<Result<CartResponse>> getCartData();
}
