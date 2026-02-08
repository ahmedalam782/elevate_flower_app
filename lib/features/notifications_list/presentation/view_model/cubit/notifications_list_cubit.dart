import 'package:elevate_flower_app/core/config/base_state/base_state.dart';
import 'package:elevate_flower_app/features/notifications_list/domain/use_cases/get_notifications_list_use_case.dart';
import 'package:elevate_flower_app/features/notifications_list/presentation/view_model/cubit/notifications_list_events.dart';
import 'package:elevate_flower_app/features/notifications_list/presentation/view_model/cubit/notifications_list_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class NotificationsListCubit extends Cubit<NotificationsListStates> {
  NotificationsListCubit(this._getNotificationsListUseCase)
      : super(NotificationsListStates());
      
  final GetNotificationsListUseCase _getNotificationsListUseCase;

  void doIntent(NotificationsListEvents event) {
    event.when(getNotifications: _getNotifications);
  }

  void _getNotifications() async {
    emit(state.copyWith(getNotificationsState: const BaseState.loading()));
    
    final result = await _getNotificationsListUseCase();
    
    result.when(
      success: (data) {
        emit(state.copyWith(getNotificationsState: BaseState.success(data)));
      },
      error: (exception) {
        emit(state.copyWith(getNotificationsState: BaseState.error(exception)));
      },
    );
  }
}