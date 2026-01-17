// ignore_for_file: public_member_api_docs, sort_constructors_first
// TODO: presentation CartStates

import 'package:elevate_flower_app/core/config/base_state/base_state.dart';
import 'package:elevate_flower_app/features/cart/domain/entities/cart_entity.dart';

class CartStates {
  final BaseState<CartEntity> state;
  bool isAddingItem;
  bool isDecrementingItem;
  bool isRemovingItem;
  int? currentActedUponItemIndex;
  double? totalPrice;

  CartStates({
    required this.state,
    required this.isAddingItem,
    required this.isDecrementingItem,
    required this.isRemovingItem,
    this.currentActedUponItemIndex,
    this.totalPrice,
  });

  CartStates copyWith({
    BaseState<CartEntity>? state,
    bool? isAddingItem,
    bool? isDecrementingItem,
    bool? isRemovingItem,
    int? currentActedUponItemIndex,
    double? totalPrice,
  }) {
    return CartStates(
      state: state ?? this.state,
      isAddingItem: isAddingItem ?? this.isAddingItem,
      isDecrementingItem: isDecrementingItem ?? this.isDecrementingItem,
      isRemovingItem: isRemovingItem ?? this.isRemovingItem,
      currentActedUponItemIndex:
          currentActedUponItemIndex ?? this.currentActedUponItemIndex,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }
}
