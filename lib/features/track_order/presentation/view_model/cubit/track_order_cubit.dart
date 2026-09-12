import 'dart:async';
import 'dart:developer';

import 'package:elevate_flower_app/core/config/base_state/base_state.dart';
import 'package:elevate_flower_app/core/utils/constants/app_strings.dart';
import 'package:elevate_flower_app/features/track_order/domain/use_cases/get_order_details_use_case.dart';
import 'package:elevate_flower_app/features/track_order/domain/use_cases/listen_to_driver_location_use_case.dart';
import 'package:elevate_flower_app/features/track_order/domain/use_cases/listen_to_order_state_use_case.dart';
import 'package:elevate_flower_app/features/track_order/presentation/view_model/cubit/track_order_events.dart';
import 'package:elevate_flower_app/features/track_order/presentation/view_model/cubit/track_order_states.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class TrackOrderCubit extends Cubit<TrackOrderState> {
  final GetOrderDetailsUseCase _getOrderDetailsUseCase;
  final ListenToDriverLocationUseCase _listenToDirverLocationUseCase;
  final ListenToOrderStateUseCase _listenToOrderStateUseCase;
  StreamSubscription? _stateStreamSubscription;
  StreamSubscription? _driverLocationtreamSubscription;
  String? style;

  TrackOrderCubit(
    this._getOrderDetailsUseCase,
    this._listenToDirverLocationUseCase,
    this._listenToOrderStateUseCase,
  ) : super(const TrackOrderState.init()) {
    _getMapStyle(path: AppStrings.mapStyle).then((value) => style = value);
  }

  void doIntent(TrackOrderEvents event) {
    switch (event) {
      case ListenToOrderStateEvent():
        if (_stateStreamSubscription == null) {
          _listenToOrderState(orderId: event.orderId);
        }

      case ListenToDriverLocationEvent():
        if (_driverLocationtreamSubscription == null) { 
          _listenToDriverLocation(orderId: event.orderId);
        }

      case GetOrderDetailsEvent():
        if (state.orderDetails.state != StateType.success) {
          _getOrderDetails(orderId: event.orderId);
        }
    }
  }

  Future<void> _getOrderDetails({required String orderId}) async {
    emit(state.copyWith(orderDetails: const BaseState.loading()));
    final result = await _getOrderDetailsUseCase(orderId: orderId);
    result.when(
      success: (data) {
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
            success: (data) {
              log("lat on cubit: ${data!.lat}");
              log("lng on cubit: ${data.lng}");
              emit(state.copyWith(driverLocation: BaseState.success(data)));
            },
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

  Future<String?> _getMapStyle({required String path}) async {
    final style = await rootBundle.loadString(path);
    return style;
  }
}
