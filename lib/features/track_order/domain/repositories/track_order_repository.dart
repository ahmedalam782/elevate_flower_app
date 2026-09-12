import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/track_order/domain/entities/track_order_entity.dart';

abstract class TrackOrderRepository {
  Future<Result<TrackOrderEntity>> getOrderDetails({required String orderId});
  Stream<Result<String?>> listenToOrderState({required String orderId});
  Stream<Result<DriverLocationEntity>> listenToDriverLocation({required String orderId});

}
