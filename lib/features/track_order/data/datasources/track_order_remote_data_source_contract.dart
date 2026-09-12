import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/track_order/data/models/firestore_order_details_model.dart';
import 'package:elevate_flower_app/features/track_order/data/models/firestore_order_driver_model.dart';

abstract class TrackOrderRemoteDataSourceContract {
  Future<Result<FirestoreOrderDetailsModel?>> getOrderDetails({required String orderId});
  Stream<Result<String?>> listenToOrderState({required String orderId});
  Stream<Result<FirestoreDriverLocationModel?>> listenToDriverLocation({required String orderId});

}
