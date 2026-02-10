import 'package:dio/dio.dart';
import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/core/config/base_state/base_state.dart';
import 'package:elevate_flower_app/features/orders_page/domain/entities/orders_entity.dart';
import 'package:elevate_flower_app/features/orders_page/domain/use_cases/get_orders_usecase.dart';
import 'package:elevate_flower_app/features/orders_page/presentation/view_model/cubit/orders_page_events.dart';
import 'package:elevate_flower_app/features/orders_page/presentation/view_model/cubit/orders_page_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class OrdersPageCubit extends Cubit<OrdersPageStates> {
  final GetOrdersUsecase _getOrdersUsecase; // ✅ الـ field الأول
  
  OrdersPageCubit(this._getOrdersUsecase) // ✅ الـ constructor بعدها
      : super(const OrdersPageStates.initial());

  void doIntent(OrdersPageEvents event) {
    switch (event) {
      case GetAllOrdersEvent():
        _getAllOrders();
    }
  }

  Future<void> _getAllOrders() async {
    // Emit Loading using copyWith
    emit(
      state.copyWith(
        state: StateType.loading,
      ),
    );

    // Call Use Case
    Result<OrdersEntity> result = await _getOrdersUsecase();

    // Handle Result using switch
    switch (result) {
      case Success<OrdersEntity>():
        emit(
          state.copyWith(
            state: StateType.success,
            data: result.data,
          ),
        );
        
      case Error<OrdersEntity>():
        String errorMessage = result.exception.toString();
        
        // Handle Dio Exceptions
        if (result.exception is DioException) {
          errorMessage = "No internet connection or server error";
        }
        
        emit(
          state.copyWith(
            state: StateType.error,
            exception: Exception(errorMessage),
          ),
        );
    }
  }
}