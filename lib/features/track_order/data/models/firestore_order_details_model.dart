import 'package:elevate_flower_app/features/track_order/data/models/firestore_order_driver_model.dart';
import 'package:elevate_flower_app/features/track_order/data/models/firestore_order_item_model.dart';
import 'package:elevate_flower_app/features/track_order/data/models/firestore_order_model.dart';
import 'package:elevate_flower_app/features/track_order/data/models/firestore_order_store_model.dart';
import 'package:elevate_flower_app/features/track_order/data/models/firestore_order_user_model.dart';

class FirestoreOrderDetailsModel {
  final FirestoreOrderModel order;
  final FirestoreOrderDriverModel driver;
  final FirestoreOrderUserModel user;
  final FirestoreOrderStoreModel store;
  final List<FirestoreOrderItemModel> items;

  const FirestoreOrderDetailsModel({
    required this.order,
    required this.driver,
    required this.user,
    required this.store,
    required this.items,
  });
}
