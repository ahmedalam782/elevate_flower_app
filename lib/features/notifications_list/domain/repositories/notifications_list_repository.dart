import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/notifications_list/domain/entities/notification_item_entity.dart';

abstract class NotificationsListRepository {
  Future<Result<List<NotificationItemEntity>>> getNotificationsList();
}