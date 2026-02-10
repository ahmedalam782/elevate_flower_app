import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/orders_page/data/datasources/orders_page_remote_data_source_contract.dart';
import 'package:elevate_flower_app/features/orders_page/data/models/order_mapper.dart';
import 'package:elevate_flower_app/features/orders_page/data/models/orders_response.dart';
import 'package:elevate_flower_app/features/orders_page/domain/entities/orders_entity.dart';
import 'package:elevate_flower_app/features/orders_page/domain/repositories/orders_page_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: OrdersPageRepository)
class OrdersPageRepositoryImpl implements OrdersPageRepository {
  final OrdersPageRemoteDataSourceContract remoteDataSource;
  
  OrdersPageRepositoryImpl(this.remoteDataSource); 

  @override
  Future<Result<OrdersEntity>> getOrders() async {
    Result<OrdersResponse> response = await remoteDataSource.getOrders();

    return response.when(
      success: (data) => Success<OrdersEntity>(data: data!.toEntity()),
      error: (exception) => Error<OrdersEntity>(exception: exception),
    );
  }
}