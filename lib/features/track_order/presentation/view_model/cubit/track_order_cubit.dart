import 'dart:async';
import 'dart:developer';

import 'package:elevate_flower_app/core/config/base_state/base_state.dart';
import 'package:elevate_flower_app/features/track_order/domain/use_cases/get_order_details_use_case.dart';
import 'package:elevate_flower_app/features/track_order/domain/use_cases/listen_to_driver_location_use_case.dart';
import 'package:elevate_flower_app/features/track_order/domain/use_cases/listen_to_order_state_use_case.dart';
import 'package:elevate_flower_app/features/track_order/presentation/view_model/cubit/track_order_events.dart';
import 'package:elevate_flower_app/features/track_order/presentation/view_model/cubit/track_order_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class TrackOrderCubit extends Cubit<TrackOrderState> {
  final GetOrderDetailsUseCase _getOrderDetailsUseCase;
  final ListenToDriverLocationUseCase _listenToDirverLocationUseCase;
  final ListenToOrderStateUseCase _listenToOrderStateUseCase;
  StreamSubscription? _stateStreamSubscription;
  StreamSubscription? _driverLocationtreamSubscription;

  TrackOrderCubit(
    this._getOrderDetailsUseCase,
    this._listenToDirverLocationUseCase,
    this._listenToOrderStateUseCase,
  ) : super(const TrackOrderState.init());

  void doIntent(TrackOrderEvents event) {
    switch (event) {
      case ListenToOrderStateEvent():
        _listenToOrderState(orderId: event.orderId);

      case ListenToDriverLocationEvent():
        _listenToDriverLocation(orderId: event.orderId);

      case GetOrderDetailsEvent():
        _getOrderDetails(orderId: event.orderId);
    }
  }

  Future<void> _getOrderDetails({required String orderId}) async {
    emit(state.copyWith(orderDetails: const BaseState.loading()));
    final result = await _getOrderDetailsUseCase(orderId: orderId);
    result.when(
      success: (data) {
        log(
          "${data!.arrivedAtPickUpAt?.toDate().day ?? "nooo day"}this is the fuck",
        );
        emit(state.copyWith(orderDetails: BaseState.success(data)));
      },
      error: (exception) =>
          emit(state.copyWith(orderDetails: BaseState.error(exception))),
    );
  }

  Future<void> _listenToOrderState({required String orderId}) async {
    emit(state.copyWith(orderState: const BaseState.loading()));
    _stateStreamSubscription = _listenToOrderStateUseCase(orderId: orderId)
        .listen((event) {
          event.when(
            success: (data) =>
                emit(state.copyWith(orderState: BaseState.success(data))),
            error: (exception) =>
                emit(state.copyWith(orderState: BaseState.error(exception))),
          );
        });
  }

  Future<void> _listenToDriverLocation({required String orderId}) async {
    emit(state.copyWith(driverLocation: const BaseState.loading()));
    _stateStreamSubscription = _listenToDirverLocationUseCase(orderId: orderId)
        .listen((event) {
          event.when(
            success: (data) =>
                emit(state.copyWith(driverLocation: BaseState.success(data))),
            error: (exception) => emit(
              state.copyWith(driverLocation: BaseState.error(exception)),
            ),
          );
        });
  }

  @override
  Future<void> close() async {
    if (_stateStreamSubscription != null) {
      await _stateStreamSubscription!.cancel();
    }
    if (_driverLocationtreamSubscription != null) {
      await _driverLocationtreamSubscription!.cancel();
    }
    super.close();
  }
}
