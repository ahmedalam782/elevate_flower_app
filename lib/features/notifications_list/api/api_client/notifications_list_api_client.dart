import 'package:dio/dio.dart';
import 'package:elevate_flower_app/core/config/api/end_points.dart';
import 'package:elevate_flower_app/features/notifications_list/data/models/notifications_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'notifications_list_api_client.g.dart';

@RestApi(baseUrl: EndPoints.baseUrl)
@lazySingleton
abstract class NotificationsListApiClient {
  @factoryMethod
  factory NotificationsListApiClient(Dio dio) = _NotificationsListApiClient;

  @GET(EndPoints.notifications)
  Future<NotificationsResponseModel> getAllNotifications();
}
