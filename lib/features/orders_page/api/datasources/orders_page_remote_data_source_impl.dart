// TODO: api Orders_pageRemoteDataSourceImpl
import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/orders_page/api/api_client/orders_page_api_client.dart';
import 'package:elevate_flower_app/features/orders_page/data/datasources/orders_page_remote_data_source_contract.dart';
import 'package:elevate_flower_app/features/orders_page/data/models/orders_response.dart';
import 'package:injectable/injectable.dart';

@Injectable(as:OrdersPageRemoteDataSourceContract)
class OrdersPageRemoteDataSourceImpl implements OrdersPageRemoteDataSourceContract{
  OrdersPageRemoteDataSourceImpl(OrdersPageApiClient ordersPageApiClient)
    : _ordersPageApiClient = ordersPageApiClient;
  final OrdersPageApiClient _ordersPageApiClient;

  @override
  Future<Result<OrdersResponse>> getOrders()async {
    try {
      OrdersResponse response = await _ordersPageApiClient.getOrders();
      return Success<OrdersResponse>(data: response);
    } catch (e) {
      return Error<OrdersResponse>(exception: Exception(e.toString()));
    }
  }
}
