import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/notifications_list/domain/entities/notification_item_entity.dart';
import 'package:elevate_flower_app/features/notifications_list/domain/repositories/notifications_list_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetNotificationsListUseCase {
  final NotificationsListRepository repository;

  GetNotificationsListUseCase(this.repository);

  Future<Result<List<NotificationItemEntity>>> call() async {
    return await repository.getNotificationsList();
  }
}