import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elevate_flower_app/features/track_order/data/models/firestore_order_details_model.dart';
import 'package:elevate_flower_app/features/track_order/data/models/firestore_order_driver_model.dart';
import 'package:elevate_flower_app/features/track_order/data/models/firestore_order_item_model.dart';
import 'package:elevate_flower_app/features/track_order/data/models/firestore_order_model.dart';
import 'package:elevate_flower_app/features/track_order/data/models/firestore_order_store_model.dart';
import 'package:elevate_flower_app/features/track_order/data/models/firestore_order_user_model.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class TrackOrderFirestoreApiClient {
  static const String _ordersCollectionName = 'orders';
  static const String _driversCollectionName = 'drivers';
  static const String _orderItemsCollectionName = 'orderItems';
  static const String _userCollectionName = 'user';
  static const String _storeCollectionName = 'store';

  final FirebaseFirestore _firestore;

  TrackOrderFirestoreApiClient([FirebaseFirestore? firestore])
    : _firestore = firestore ?? FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _ordersCollection =>
      _firestore.collection(_ordersCollectionName);

  CollectionReference<Map<String, dynamic>> _driversCollection(
    String orderId,
  ) => _ordersCollection.doc(orderId).collection(_driversCollectionName);

  CollectionReference<Map<String, dynamic>> _orderItemsCollection(
    String orderId,
  ) => _ordersCollection.doc(orderId).collection(_orderItemsCollectionName);

  CollectionReference<Map<String, dynamic>> _userCollection(String orderId) =>
      _ordersCollection.doc(orderId).collection(_userCollectionName);

  CollectionReference<Map<String, dynamic>> _storeCollection(String orderId) =>
      _ordersCollection.doc(orderId).collection(_storeCollectionName);

  // GET DATA
  Future<FirestoreOrderModel?> getOrderById(String orderId) async {
    final snapshot = await _ordersCollection.doc(orderId).get();
    if (!snapshot.exists) {
      return null;
    }
    return FirestoreOrderModel.fromDocument(snapshot);
  }

  Future<FirestoreOrderDetailsModel> getOrderDetails(String orderId) async {
    List response = await Future.wait([
      getOrderById(orderId),
      getOrderDriver(orderId),
      getOrderStore(orderId),
      getOrderItems(orderId),
    ]);
    log("${(response[2] as FirestoreOrderStoreModel).lat}");
    return FirestoreOrderDetailsModel(
      order: response[0]!,
      driver: response[1]!,
      user: FirestoreOrderUserModel(
        address: "",
        firstName: "",
        id: "",
        lastName: "",
        lat: 1,
        lng: 1,
        phone: "",
        photo: orderId,
      ),
      store: response[2]!,
      items: response[3],
    );
  }

  Future<void> updateOrderState({
    required String orderId,
    required String state,
  }) async {
    await _ordersCollection.doc(orderId).update({'state': state});
  }

  Stream<String?> listenToOrderState(String orderId) {
    return _ordersCollection.doc(orderId).snapshots().map((snapshot) {
      if (!snapshot.exists) {
        return null;
      }

      return snapshot.data()?['state']?.toString();
    });
  }

  Future<FirestoreOrderDriverModel?> getOrderDriver(String orderId) async {
    final snapshot = await _driversCollection(orderId).get();
    if (snapshot.docs.isNotEmpty) {
      return snapshot.docs
          .map(FirestoreOrderDriverModel.fromDocument)
          .toList()
          .first;
    }
    return null;
  }

  Stream<FirestoreDriverLocationModel?> listenToOrderDriverLocation({
    required String orderId,
  }) async* {
    final driver = await getOrderDriver(orderId);

    yield* _driversCollection(orderId).doc(driver?.id).snapshots().map((
      snapshot,
    ) {
      if (!snapshot.exists) {
        return null;
      }

      final data = snapshot.data();
      if (data == null) {
        return null;
      }

      return FirestoreDriverLocationModel.fromJson(data);
    });
  }

  Future<FirestoreOrderUserModel?> getOrderUser(String orderId) async {
    final snapshot = await _userCollection(orderId).get();
    if (snapshot.docs.isNotEmpty) {
      return snapshot.docs
          .map(FirestoreOrderUserModel.fromDocument)
          .toList()
          .first;
    }
    return null;
  }

  Future<FirestoreOrderStoreModel?> getOrderStore(String orderId) async {
    final snapshot = await _storeCollection(orderId).get();
    if (snapshot.docs.isNotEmpty) {
      return snapshot.docs
          .map(FirestoreOrderStoreModel.fromDocument)
          .toList()
          .first;
    }
    return null;
  }

  Future<List<FirestoreOrderItemModel>> getOrderItems(String orderId) async {
    final snapshot = await _orderItemsCollection(orderId).get();
    return snapshot.docs.map(FirestoreOrderItemModel.fromDocument).toList();
  }
}
