// TODO: presentation CartCubit

import 'dart:developer';

import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/core/config/base_state/base_state.dart';
import 'package:elevate_flower_app/core/errors/failures.dart';
import 'package:elevate_flower_app/features/cart/data/models/post/cart_product_post_data.dart';
import 'package:elevate_flower_app/features/cart/domain/entities/cart_entity.dart';
import 'package:elevate_flower_app/features/cart/domain/use_cases/add_product_to_cart_use_case.dart';
import 'package:elevate_flower_app/features/cart/domain/use_cases/clear_user_cart_use_case.dart';
import 'package:elevate_flower_app/features/cart/domain/use_cases/get_cart_data_use_case.dart';
import 'package:elevate_flower_app/features/cart/domain/use_cases/remove_product_from_cart_use_case.dart';
import 'package:elevate_flower_app/features/cart/presentation/view_model/cubit/cart_events.dart';
import 'package:elevate_flower_app/features/cart/presentation/view_model/cubit/cart_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class CartCubit extends Cubit<CartStates> {
  CartCubit({
    required GetCartDataUseCase getCartDataUseCase,
    required AddProductToCartUseCase addProductToCartUseCase,
    required RemoveProductFromCartUseCase removeProductFromCartUseCase,
    required ClearUserCartUseCase clearUserCartUseCase,
  }) : _getCartDataUseCase = getCartDataUseCase,
       _addProductToCartUseCase = addProductToCartUseCase,
       _removeProductFromCartUseCase = removeProductFromCartUseCase,
       _clearUserCartUseCase = clearUserCartUseCase,
       super(CartStates.initial());

  final GetCartDataUseCase _getCartDataUseCase;
  final AddProductToCartUseCase _addProductToCartUseCase;
  final RemoveProductFromCartUseCase _removeProductFromCartUseCase;
  final ClearUserCartUseCase _clearUserCartUseCase;

  // ======================
  // MVI ENTRY POINT
  // ======================
  Future<dynamic> doIntent(CartEvents event) async {
    switch (event) {
      case GetCartDataEvent():
        await _loadCart();

      case AddProductToCartEvent():
        return await _addProduct(
          productId: event.productId,
          fromCartScreen: event.fromCartScreen,
        );

      case RemoveProductFromCartEvent():
        await _removeProduct(productId: event.productId);

      case ClearUserCartEvent():
        await _clearCart();
    }
  }

  // ======================
  // ACTIONS
  // ======================

  Future<void> _loadCart() async {
    emit(state.copyWith(state: const BaseState.loading()));

    final result = await _getCartDataUseCase();

    switch (result) {
      case Success<CartEntity>():
        emit(
          state.copyWith(
            state: BaseState.success(result.data),
            totalPrice: result.data?.totalPrice ?? 0,
          ),
        );

      case Error<CartEntity>():
        emit(state.copyWith(state: BaseState.error(result.exception)));
    }
  }

  Future<dynamic> _addProduct({
    required String productId,
    bool fromCartScreen = true,
  }) async {
    CartEntity? updatedCart;
    emit(
      state.copyWith(isAddingItem: true, currentActedUponProductId: productId),
    );

    final result = await _addProductToCartUseCase(
      CartProductPostData(product: productId),
    );

    switch (result) {
      case Success<void>():
        updatedCart = _reduceAddProduct(
          productId,
          fromCartScreen: fromCartScreen,
        );
        emit(
          state.copyWith(
            isAddingItem: false,
            state: BaseState.success(updatedCart),
            totalPrice: updatedCart?.totalPrice ?? 0,
            currentActedUponProductId: "",
          ),
        );
        return true;

      case Error<void>():
        emit(
          state.copyWith(
            isAddingItem: false,
            state: BaseState.error(result.exception),
            currentActedUponProductId: "",
          ),
        );
        return result.exception;
      // return true;
    }
  }

  Future<void> _removeProduct({required String productId}) async {
    emit(
      state.copyWith(
        isRemovingItem: true,
        currentActedUponProductId: productId,
      ),
    );

    final result = await _removeProductFromCartUseCase(productId);

    switch (result) {
      case Success<void>():
        final updatedCart = _reduceRemoveProduct(productId);
        emit(
          state.copyWith(
            isRemovingItem: false,
            state: BaseState.success(updatedCart),
            totalPrice: updatedCart.totalPrice,
            currentActedUponProductId: "",
          ),
        );

      case Error<void>():
        emit(
          state.copyWith(
            isRemovingItem: false,
            state: BaseState.error(result.exception),
            currentActedUponProductId: "",
          ),
        );
    }
  }

  Future<void> _clearCart() async {
    emit(state.copyWith(state: const BaseState.loading()));

    final result = await _clearUserCartUseCase();

    switch (result) {
      case Success<void>():
        emit(CartStates.initial());

      case Error<void>():
        emit(state.copyWith(state: BaseState.error(result.exception)));
    }
  }

  // ======================
  // REDUCERS (PURE & IMMUTABLE)
  // ======================

  CartEntity? _reduceAddProduct(
    String productId, {
    bool fromCartScreen = true,
  }) {
    print(fromCartScreen);
    if (!fromCartScreen) return null;
    final cart = state.state.data!;
    final updatedProducts = cart.cartProducts.map((item) {
      if (item.id == productId) {
        return item.copyWith(
          productQuantityInCart: item.productQuantityInCart + 1,
        );
      }
      return item;
    }).toList();

    final price = cart.cartProducts
        .firstWhere((e) => e.id == productId)
        .productPrice;

    return cart.copyWith(
      cartProducts: updatedProducts,
      totalPrice: cart.totalPrice + price,
    );
  }

  CartEntity _reduceRemoveProduct(String productId) {
    final cart = state.state.data!;
    final removed = cart.cartProducts.firstWhere((e) => e.id == productId);

    return cart.copyWith(
      cartProducts: cart.cartProducts.where((e) => e.id != productId).toList(),
      totalPrice:
          cart.totalPrice -
          (removed.productPrice * removed.productQuantityInCart),
    );
  }
}
