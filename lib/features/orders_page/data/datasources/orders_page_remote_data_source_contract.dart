// TODO: data Orders_pageRemoteDataSourceContract
import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/orders_page/data/models/orders_response.dart';

abstract class OrdersPageRemoteDataSourceContract {
  Future<Result<OrdersResponse>>getOrders();
    
}