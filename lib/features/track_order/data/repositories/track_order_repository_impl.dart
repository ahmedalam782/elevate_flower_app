import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/track_order/data/datasources/track_order_remote_data_source_contract.dart';
import 'package:elevate_flower_app/features/track_order/data/mapper/order_mapper.dart';
import 'package:elevate_flower_app/features/track_order/domain/entities/track_order_entity.dart';
import 'package:elevate_flower_app/features/track_order/domain/repositories/track_order_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: TrackOrderRepository)
class TrackOrderRepositoryImpl implements TrackOrderRepository {
  final TrackOrderRemoteDataSourceContract dataSource;

  TrackOrderRepositoryImpl({required this.dataSource});
  @override
  Future<Result<TrackOrderEntity>> getOrderDetails({
    required String orderId,
  }) async {
    final result = await dataSource.getOrderDetails(orderId: orderId);
    return result.when(
      success: (data) => Success(data: data!.toEntity()),
      error: (exception) => Error(exception: exception),
    );
  }

  @override
  Stream<Result<DriverLocationEntity>> listenToDriverLocation({
    required String orderId,
  }) {
    return dataSource
        .listenToDriverLocation(orderId: orderId)
        .map(
          (event) => event.when(
            success: (data) => Success(
              data: DriverLocationEntity(lat: data!.lat, lng: data.lng),
            ),
            error: (exception) => Error(exception: exception),
          ),
        );
  }

  @override
  Stream<Result<String?>> listenToOrderState({required String orderId}) {
    return dataSource.listenToOrderState(orderId: orderId);
  }
}
