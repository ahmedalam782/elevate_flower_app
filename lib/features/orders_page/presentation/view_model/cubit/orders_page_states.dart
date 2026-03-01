import 'package:elevate_flower_app/core/config/base_state/base_state.dart';
import 'package:elevate_flower_app/features/orders_page/domain/entities/orders_entity.dart';

class OrdersPageStates extends BaseState<OrdersEntity> {
  const OrdersPageStates({
    super.state,
    super.data,
    super.exception,
  });

  // Initial State
  const OrdersPageStates.initial() : super.initial();

  // Loading State
  const OrdersPageStates.loading() : super.loading();

  // Success State
  const OrdersPageStates.success(OrdersEntity super.data) : super.success();

  // Error State
  const OrdersPageStates.error(Exception super.exception) : super.error();

  // More Loading State (for pagination)
  const OrdersPageStates.moreLoading(OrdersEntity? data)
      : super.all(
          state: StateType.moreLoading,
          data: data,
          exception: null,
        );

  // Copy With for updating state
  OrdersPageStates copyWith({
    StateType? state,
    OrdersEntity? data,
    Exception? exception,
  }) {
    return OrdersPageStates(
      state: state ?? this.state,
      data: data ?? this.data,
      exception: exception ?? this.exception,
    );
  }
}