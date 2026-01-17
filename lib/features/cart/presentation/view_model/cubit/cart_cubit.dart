// TODO: presentation CartCubit

import 'dart:developer';

import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/core/config/base_state/base_state.dart';
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

@injectable
class CartCubit extends Cubit<CartStates> {
  CartCubit({
    required GetCartDataUseCase getSpeceficProductUsecase,
    required AddProductToCartUseCase addProductToCartUsecase,
    required RemoveProductFromCartUseCase removeProductFromCartUsecase,
    required ClearUserCartUseCase clearProductFromCartUsecase,
  }) : _getCartDataUseCase = getSpeceficProductUsecase,
       _addProductToCartUseCase = addProductToCartUsecase,
       _removeProductFromCartUseCase = removeProductFromCartUsecase,
       _clearProductFromCartUseCase = clearProductFromCartUsecase,
       super(
         CartStates(
           state: const BaseState<CartEntity>.initial(),
           isAddingItem: false,
           isDecrementingItem: false,
           isRemovingItem: false,
           currentActedUponItemIndex: -1,
         ),
       );
  final GetCartDataUseCase _getCartDataUseCase;
  final AddProductToCartUseCase _addProductToCartUseCase;
  final RemoveProductFromCartUseCase _removeProductFromCartUseCase;
  final ClearUserCartUseCase _clearProductFromCartUseCase;

  Future<void> doIntent(CartEvents event) async => switch (event) {
    GetCartDataEvent() => getCartData(),
    AddProductToCartEvent() => addOneItemToCart(event.index),
    RemoveProductFromCartEvent() => _removeItemFromCartApICall(event.index),
    ClearUserCartEvent() => _clearUserCart(),
  };

  Future<void> getCartData() async {
    emit(state.copyWith(state: BaseState<CartEntity>.loading()));
    final response = await _getCartDataUseCase.call();
    switch (response) {
      case Success<CartEntity>():
        emit(
          state.copyWith(
            state: BaseState<CartEntity>.success(response.data),
            totalPrice: response.data?.totalPrice.toDouble() ?? 0,
          ),
        );

      case Error<CartEntity>():
        emit(
          state.copyWith(
            state: BaseState<CartEntity>.error(response.exception),
          ),
        );
    }
  }

  Future<void> addOneItemToCart(int index) async {
    emit(
      state.copyWith(
        isAddingItem: true,
        isRemovingItem: false,
        isDecrementingItem: false,
        currentActedUponItemIndex: index,
      ),
    );
    final response = await _addProductToCartUseCase.call(
      CartProductPostData(
        product: state.state.data?.cartProducts[index].id ?? "",
      ),
    );
    switch (response) {
      case Success<void>():
        final cartEntity = _updateDataAfterIncrement(index);
        emit(
          state.copyWith(
            isAddingItem: false,
            currentActedUponItemIndex: -1,
            state: BaseState<CartEntity>.success(cartEntity),
            totalPrice: cartEntity?.totalPrice,
          ),
        );

      case Error<void>():
        emit(
          state.copyWith(
            state: BaseState<CartEntity>.error(response.exception),
          ),
        );
    }
  }

  Future<void> _removeItemFromCartApICall(int index) async {
    emit(
      state.copyWith(
        isAddingItem: false,
        isRemovingItem: true,
        isDecrementingItem: false,
        currentActedUponItemIndex: index,
      ),
    );
    final response = await _removeProductFromCartUseCase.call(
      state.state.data?.cartProducts[index].id ?? "",
    );
    switch (response) {
      case Success<void>():
        log("LAST INDEX${index}");
        final cartEntity = _updateDateAfterRemoving(index);
        emit(
          state.copyWith(
            isRemovingItem: false,
            currentActedUponItemIndex: -1,
            state: BaseState<CartEntity>.success(cartEntity),
            totalPrice: cartEntity?.totalPrice,
          ),
        );

      case Error<void>():
        emit(
          state.copyWith(
            state: BaseState<CartEntity>.error(response.exception),
          ),
        );
    }
  }

  Future<void> _clearUserCart() async {
    emit(state.copyWith(state: BaseState<CartEntity>.loading()));
    final response = await _clearProductFromCartUseCase.call();
    switch (response) {
      case Success<void>():
        getCartData();

      case Error<void>():
        emit(
          state.copyWith(
            state: BaseState<CartEntity>.error(response.exception),
          ),
        );
    }
  }

  CartEntity? _updateDataAfterIncrement(int index) {
    final newData = state.state.data;
    newData?.cartProducts[index].productQuantityInCart++;
    newData?.totalPrice += newData.cartProducts[index].productPrice;

    return newData;
  }

  CartEntity? _updateDateAfterRemoving(int index) {
    final oldData = state.state.data;
    if (oldData == null) return null;

    // 1️⃣ Copy the list (DO NOT mutate state directly)
    final updatedProducts = List<CartProductEntity>.from(oldData.cartProducts);

    // 2️⃣ Capture the removed item BEFORE removal
    final removedItem = updatedProducts[index];

    // 3️⃣ Remove item
    updatedProducts.removeAt(index);

    // 4️⃣ Calculate updated total price
    final updatedTotalPrice =
        oldData.totalPrice -
        (removedItem.productPrice * removedItem.productQuantityInCart);

    // 5️⃣ Return new CartEntity (immutable update)
    return oldData.copyWith(
      cartProducts: updatedProducts,
      totalPrice: updatedTotalPrice,
    );
  }
}
