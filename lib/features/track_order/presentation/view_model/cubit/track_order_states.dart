import 'package:elevate_flower_app/core/config/base_state/base_state.dart';
import 'package:elevate_flower_app/features/track_order/domain/entities/track_order_entity.dart';
import 'package:equatable/equatable.dart';

class TrackOrderState extends Equatable {
  final BaseState<TrackOrderEntity> orderDetails;
  final BaseState<DriverLocationEntity> driverLocation;
  final BaseState<String> orderState;

  const TrackOrderState({
    required this.driverLocation,
    required this.orderDetails,
    required this.orderState,
  });
  const TrackOrderState.init()
    : orderDetails = const BaseState.initial(),
      driverLocation = const BaseState.initial(),
      orderState = const BaseState.initial();

  @override
  List<Object?> get props => [orderDetails, driverLocation, orderState];

  TrackOrderState copyWith({
    BaseState<DriverLocationEntity>? driverLocation,
    BaseState<TrackOrderEntity>? orderDetails,
    BaseState<String>? orderState,
  }) => TrackOrderState(
    driverLocation: driverLocation ?? this.driverLocation,
    orderDetails: orderDetails ?? this.orderDetails,
    orderState: orderState ?? this.orderState,
  );
}
