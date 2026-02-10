
import 'package:dio/dio.dart';
import 'package:elevate_flower_app/core/config/api/end_points.dart';
import 'package:elevate_flower_app/features/orders_page/data/models/orders_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'orders_page_api_client.g.dart';

@injectable
@RestApi()
abstract class OrdersPageApiClient {
  @factoryMethod
  factory OrdersPageApiClient(Dio dio) = _OrdersPageApiClient;

  @GET(EndPoints.ordersPage)
  Future<OrdersResponse> getOrders();
}