import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/orders_page/domain/entities/orders_entity.dart';

abstract class OrdersPageRepository {
  Future<Result<OrdersEntity>>getOrders();
}