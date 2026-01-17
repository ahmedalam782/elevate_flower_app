// TODO: data CartRepositoryImpl

import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/cart/data/datasources/cart_remote_data_source_contract.dart';
import 'package:elevate_flower_app/features/cart/data/models/cart_response.dart';
import 'package:elevate_flower_app/features/cart/data/models/post/cart_product_post_data.dart';
import 'package:elevate_flower_app/features/cart/domain/entities/cart_entity.dart';
import 'package:elevate_flower_app/features/cart/domain/repositories/cart_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CartRepository)
class CartRepositoryImpl implements CartRepository {
  final CartRemoteDataSourceContract carRemoteDataSourceContract;

  CartRepositoryImpl({required this.carRemoteDataSourceContract});
  @override
  Future<Result<CartEntity>> getCartData() async {
    final response = await carRemoteDataSourceContract.getCartData();
    switch (response) {
      case Success<CartResponse>():
        return Success<CartEntity>(data: response.data?.toCartEntity());
      case Error<CartResponse>():
        return Error<CartEntity>(exception: response.exception);
    }
  }

  @override
  Future<Result<void>> addProductToCart(CartProductPostData data) async {
    final response = await carRemoteDataSourceContract.addProductToCart(data);
    switch (response) {
      case Success<void>():
        return Success<void>();
      case Error<void>():
        return Error<void>(exception: response.exception);
    }
  }

  @override
  Future<Result<void>> removeProductFromCart(String id) async {
    final response = await carRemoteDataSourceContract.removeProductFromCart(
      id,
    );
    switch (response) {
      case Success<void>():
        return Success<void>();
      case Error<void>():
        return Error<void>(exception: response.exception);
    }
  }
}
