import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/notifications_list/data/datasources/notifications_list_remote_data_source_contract.dart';
import 'package:elevate_flower_app/features/notifications_list/domain/entities/notification_item_entity.dart';
import 'package:elevate_flower_app/features/notifications_list/domain/repositories/notifications_list_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: NotificationsListRepository)
class NotificationsListRepositoryImpl
    implements NotificationsListRepository {
  final NotificationsListRemoteDataSourceContract remoteDataSource;

  NotificationsListRepositoryImpl(this.remoteDataSource);

  @override
  Future<Result<List<NotificationItemEntity>>> getNotificationsList() async {
    final result = await remoteDataSource.getNotificationsList();

    return result.when(
      success: (data) =>
          Success(data: data?.map((model) => model.toEntity()).toList()),
      error: (exception) => Error(exception: exception),
    );
  }
}


