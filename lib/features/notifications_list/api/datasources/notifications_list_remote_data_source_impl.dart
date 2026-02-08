import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/notifications_list/api/api_client/notifications_list_api_client.dart';
import 'package:elevate_flower_app/features/notifications_list/data/datasources/notifications_list_remote_data_source_contract.dart';
import 'package:elevate_flower_app/features/notifications_list/data/models/notification_item_model.dart';
import 'package:injectable/injectable.dart';


@Injectable(as: NotificationsListRemoteDataSourceContract)

class NotificationsListRemoteDataSourceImpl implements NotificationsListRemoteDataSourceContract {
  final NotificationsListApiClient apiClient;

  NotificationsListRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<Result<List<NotificationItemModel>>> getNotificationsList() async {
    try {
    
      final notifications = await apiClient.getAllNotifications();

      return Success(data: notifications.notifications);
    } catch (e) {
      return Error(exception: Exception('Failed to fetch notifications'));
    }
  }
}
