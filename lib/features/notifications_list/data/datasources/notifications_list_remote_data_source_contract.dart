import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/notifications_list/data/models/notification_item_model.dart';

abstract class NotificationsListRemoteDataSourceContract {
  Future<Result<List<NotificationItemModel>>> getNotificationsList();
}

