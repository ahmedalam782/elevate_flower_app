sealed class NotificationsListEvents {
  const NotificationsListEvents();
  
  factory NotificationsListEvents.getNotifications() = GetNotificationsEvent;

  void when({required void Function() getNotifications}) {
    if (this is GetNotificationsEvent) {
      getNotifications();
    }
  }
}

class GetNotificationsEvent extends NotificationsListEvents {}