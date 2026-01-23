// ignore_for_file: public_member_api_docs, sort_constructors_first
// TODO: presentation CartStates

import 'package:elevate_flower_app/core/config/base_state/base_state.dart';
import 'package:elevate_flower_app/features/cart/domain/entities/cart_entity.dart';

class CartStates {
  final BaseState<CartEntity> state;
  final bool isAddingItem;
  final bool isRemovingItem;
  final bool isDecrementingItem;
  final String currentActedUponProductId;
  final double totalPrice;

  const CartStates({
    required this.state,
    required this.isAddingItem,
    required this.isRemovingItem,
    required this.isDecrementingItem,
    required this.totalPrice,
    required this.currentActedUponProductId,
  });

  factory CartStates.initial() => const CartStates(
    state: BaseState.initial(),
    isAddingItem: false,
    isRemovingItem: false,
    isDecrementingItem: false,
    totalPrice: 0,
    currentActedUponProductId: "",
  );

  CartStates copyWith({
    BaseState<CartEntity>? state,
    bool? isAddingItem,
    bool? isRemovingItem,
    bool? isDecrementingItem,
    String? currentActedUponProductId,
    double? totalPrice,
  }) {
    return CartStates(
      state: state ?? this.state,
      isAddingItem: isAddingItem ?? this.isAddingItem,
      isRemovingItem: isRemovingItem ?? this.isRemovingItem,
      isDecrementingItem: isDecrementingItem ?? this.isDecrementingItem,
      currentActedUponProductId:
          currentActedUponProductId ?? this.currentActedUponProductId,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }
}
