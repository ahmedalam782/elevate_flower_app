import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/orders_page/domain/entities/orders_entity.dart';
import 'package:elevate_flower_app/features/orders_page/domain/repositories/orders_page_repository.dart';
import 'package:injectable/injectable.dart';
@injectable
class GetOrdersUsecase {
  final OrdersPageRepository _ordersPageRepository;
  GetOrdersUsecase(this._ordersPageRepository);
  
  Future<Result<OrdersEntity>> call() {
    return _ordersPageRepository.getOrders();
  }
}