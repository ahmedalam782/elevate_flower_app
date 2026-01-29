// TODO: presentation CartCubit

import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/core/config/base_state/base_state.dart';
import 'package:elevate_flower_app/core/shared/widgets/loading_flower_widget.dart';
import 'package:elevate_flower_app/features/cart/data/models/post/cart_product_post_data.dart';
import 'package:elevate_flower_app/features/cart/data/models/post/cart_update_data.dart';
import 'package:elevate_flower_app/features/cart/domain/entities/cart_entity.dart';
import 'package:elevate_flower_app/features/cart/domain/use_cases/add_product_to_cart_use_case.dart';
import 'package:elevate_flower_app/features/cart/domain/use_cases/clear_user_cart_use_case.dart';
import 'package:elevate_flower_app/features/cart/domain/use_cases/get_cart_data_use_case.dart';
import 'package:elevate_flower_app/features/cart/domain/use_cases/remove_product_from_cart_use_case.dart';
import 'package:elevate_flower_app/features/cart/domain/use_cases/update_product_in_cart_usecase.dart';
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
    required UpdateProductInCartUsecase updateProductInCartUsecase,
  }) : _getCartDataUseCase = getCartDataUseCase,
       _addProductToCartUseCase = addProductToCartUseCase,
       _removeProductFromCartUseCase = removeProductFromCartUseCase,
       _clearUserCartUseCase = clearUserCartUseCase,
       _updateProductInCartUsecase = updateProductInCartUsecase,
       super(CartStates.initial());

  final GetCartDataUseCase _getCartDataUseCase;
  final AddProductToCartUseCase _addProductToCartUseCase;
  final RemoveProductFromCartUseCase _removeProductFromCartUseCase;
  final ClearUserCartUseCase _clearUserCartUseCase;
  final UpdateProductInCartUsecase _updateProductInCartUsecase;

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
      case UpdateProductInCartEvent():
        await _updateQuantity(
          productId: event.productId,
          quantity: event.qunatity,
        );
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
    showOverLayLoading();

    CartEntity? updatedCart;
    emit(
      state.copyWith(isAddingItem: true, currentActedUponProductId: productId),
    );

    final result = await _addProductToCartUseCase(
      CartProductPostData(product: productId),
    );
    hideOverlayLoading();
    switch (result) {
      case Success<void>():
        updatedCart = _updateCartAfterAdding(
          productId,
          fromCartScreen: fromCartScreen,
        );

        if (updatedCart != null) {
          emit(
            state.copyWith(
              isAddingItem: false,
              state: BaseState.success(updatedCart),
              totalPrice: updatedCart.totalPrice,
              currentActedUponProductId: "",
            ),
          );
        } else {
          // Refresh cart data if local update is not possible
          await _loadCart();
          emit(
            state.copyWith(isAddingItem: false, currentActedUponProductId: ""),
          );
        }
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

  Future<dynamic> _updateQuantity({
    required String productId,
    required int quantity,
  }) async {
    showOverLayLoading();

    CartEntity? updatedCart;
    emit(
      state.copyWith(
        isDecrementingItem: true,
        currentActedUponProductId: productId,
      ),
    );

    final result = await _updateProductInCartUsecase(
      productId,
      CartUpdateDataModel(quantity: --quantity),
    );
    hideOverlayLoading();

    switch (result) {
      case Success<void>():
        updatedCart = _updateCartAfterDecrementing(productId);
        emit(
          state.copyWith(
            isDecrementingItem: false,
            state: BaseState.success(updatedCart),
            totalPrice: updatedCart?.totalPrice ?? 0,
            currentActedUponProductId: "",
          ),
        );
        return true;

      case Error<void>():
        emit(
          state.copyWith(
            isDecrementingItem: false,
            state: BaseState.error(result.exception),
            currentActedUponProductId: "",
          ),
        );
        return result.exception;
      // return true;
    }
  }

  Future<void> _removeProduct({required String productId}) async {
    showOverLayLoading();

    emit(
      state.copyWith(
        isRemovingItem: true,
        currentActedUponProductId: productId,
      ),
    );

    final result = await _removeProductFromCartUseCase(productId);
    hideOverlayLoading();

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
        emit(
          state.copyWith(state: const BaseState.success(null), totalPrice: 0),
        );

      case Error<void>():
        emit(state.copyWith(state: BaseState.error(result.exception)));
    }
  }

  // ======================
  // REDUCERS (PURE & IMMUTABLE)
  // ======================

  CartEntity? _updateCartAfterAdding(
    String productId, {
    bool fromCartScreen = true,
  }) {
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

  CartEntity? _updateCartAfterDecrementing(String productId) {
    final cart = state.state.data!;
    final updatedProducts = cart.cartProducts.map((item) {
      if (item.id == productId) {
        return item.copyWith(
          productQuantityInCart: item.productQuantityInCart - 1,
        );
      }
      return item;
    }).toList();

    final price = cart.cartProducts
        .firstWhere((e) => e.id == productId)
        .productPrice;

    return cart.copyWith(
      cartProducts: updatedProducts,
      totalPrice: cart.totalPrice - price,
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
