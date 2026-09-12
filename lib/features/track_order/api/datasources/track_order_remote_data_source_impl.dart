import 'package:elevate_flower_app/core/config/api/api_executer.dart';
import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/track_order/api/api_client/track_order_firestore_api_client.dart';
import 'package:elevate_flower_app/features/track_order/data/datasources/track_order_remote_data_source_contract.dart';
import 'package:elevate_flower_app/features/track_order/data/models/firestore_order_details_model.dart';
import 'package:elevate_flower_app/features/track_order/data/models/firestore_order_driver_model.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: TrackOrderRemoteDataSourceContract)
class TrackOrderRemoteDataSourceImpl
    implements TrackOrderRemoteDataSourceContract {
  final TrackOrderFirestoreApiClient firestoreApiClient;

  TrackOrderRemoteDataSourceImpl({required this.firestoreApiClient});

  @override
  Future<Result<FirestoreOrderDetailsModel>> getOrderDetails({
    required String orderId,
  }) async {
    return await executeApi(
      () async => firestoreApiClient.getOrderDetails(orderId),
    );
  }

  @override
  Stream<Result<FirestoreDriverLocationModel?>> listenToDriverLocation({
    required String orderId,
  }) {
    return executeApiForStream(
      () => firestoreApiClient.listenToOrderDriverLocation(orderId: orderId),
    );
  }

  @override
  Stream<Result<String?>> listenToOrderState({required String orderId}) {
    return executeApiForStream(
      () => firestoreApiClient.listenToOrderState(orderId),
    );
  }
}
