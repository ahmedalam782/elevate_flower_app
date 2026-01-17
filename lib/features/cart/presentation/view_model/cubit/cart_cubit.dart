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
      super(CartStates(state: const BaseState<CartEntity>.initial()));
  final GetCartDataUseCase _getCartDataUseCase;

  Future<void> doIntent(CartEvents event) async => switch (event) {
    GetCartData() => getCartData(),
  };

  Future<void> getCartData() async {
    emit(state.copyWith(state: BaseState<CartEntity>.loading()));
    final response = await _getCartDataUseCase.call();
    switch (response) {
      case Success<CartEntity>():
        emit(
          state.copyWith(state: BaseState<CartEntity>.success(response.data)),
        );

      case Error<CartEntity>():
        emit(
          state.copyWith(
            state: BaseState<CartEntity>.error(response.exception),
          ),
        );
    }
  }
}
