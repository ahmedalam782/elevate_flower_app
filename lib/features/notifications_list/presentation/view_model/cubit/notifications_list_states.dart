import 'package:elevate_flower_app/core/config/base_state/base_state.dart';
import 'package:elevate_flower_app/features/notifications_list/domain/entities/notification_item_entity.dart';

class NotificationsListStates {
  final BaseState<List<NotificationItemEntity>> getNotificationsState;

  NotificationsListStates({
    this.getNotificationsState = const BaseState.initial(),
  });

  NotificationsListStates copyWith({
    BaseState<List<NotificationItemEntity>>? getNotificationsState,
  }) {
    return NotificationsListStates(
      getNotificationsState: getNotificationsState ?? this.getNotificationsState,
    );
  }
}