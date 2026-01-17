// TODO: presentation CartCubit

import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/core/config/base_state/base_state.dart';
import 'package:elevate_flower_app/features/cart/domain/entities/cart_entity.dart';
import 'package:elevate_flower_app/features/cart/domain/use_cases/get_cart_data_use_case.dart';
import 'package:elevate_flower_app/features/cart/presentation/view_model/cubit/cart_events.dart';
import 'package:elevate_flower_app/features/cart/presentation/view_model/cubit/cart_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class CartCubit extends Cubit<CartStates> {
  CartCubit({required GetCartDataUseCase getSpeceficProduct})
    : _getCartDataUseCase = getSpeceficProduct,
      super(
        CartStates(
          state: const BaseState<CartEntity>.initial(),
          isAddingItem: false,
          isDecrementingItem: false,
          isRemovingItem: false,
          currentActedUponItemIndex: null,
        ),
      );
  final GetCartDataUseCase _getCartDataUseCase;

  Future<void> doIntent(CartEvents event) async => switch (event) {
    GetCartData() => getCartData(),
    // TODO: Handle this case.
    AddProductToCart() => addOneItemToCart(event.index),
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
    await Future.delayed(Duration(seconds: 3));
    final cartEntity = _updateDataAfterIncrement(index);
    print(cartEntity?.totalPrice);
    emit(
      state.copyWith(
        isAddingItem: false,
        currentActedUponItemIndex: null,
        state: BaseState<CartEntity>.success(cartEntity),
        totalPrice: cartEntity?.totalPrice,
      ),
    );
  }

  CartEntity? _updateDataAfterIncrement(int index) {
    final newData = state.state.data;
    newData?.cartProducts[index].productQuantityInCart++;
    newData?.totalPrice += newData.cartProducts[index].productPrice;

    // print(newData?.totalPrice);
    return newData;
  }
}
