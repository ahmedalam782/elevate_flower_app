// TODO: presentation CartStates

import 'package:elevate_flower_app/core/config/base_state/base_state.dart';
import 'package:elevate_flower_app/features/cart/domain/entities/cart_entity.dart';

class CartStates {
  final BaseState<CartEntity> state;

  CartStates({required this.state});

  CartStates copyWith({BaseState<CartEntity>? state}) {
    return CartStates(state: state ?? this.state);
  }
}
