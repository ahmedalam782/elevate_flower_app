import 'package:elevate_flower_app/features/track_order/data/models/firestore_order_details_model.dart';
import 'package:elevate_flower_app/features/track_order/data/models/firestore_order_driver_model.dart';
import 'package:elevate_flower_app/features/track_order/data/models/firestore_order_store_model.dart';
import 'package:elevate_flower_app/features/track_order/data/models/firestore_order_user_model.dart';
import 'package:elevate_flower_app/features/track_order/domain/entities/track_order_entity.dart';

extension OrderMapper on FirestoreOrderDetailsModel {
  TrackOrderEntity toEntity() => TrackOrderEntity(
    id: order.id,
    paymentType: order.paymentType,
    state: order.state,
    totalPrice: order.totalPrice,
    acceptedAt: order.acceptedAt,
    arrivedAtPickUpAt: order.arrivedAtPickUpAt,
    deliveringAt: order.deliveringAt,
    deliveredAt: order.deliveredAt,
    completedAt: order.completedAt,
    driver: driver.toEntity(),
    user: user.toEntity(),
    store: store.toEntity(),
  );
}

extension DriverMapper on FirestoreOrderDriverModel {
  DriverEntity toEntity() => DriverEntity(
    id: id,
    firstName: firstName,
    lastName: lastName,
    phoneNumber: phoneNumber,
    photo: photo,
    vehicleImage: "",
    location: DriverLocationEntity(lat: lat, lng: lng),
  );
}

extension UserMapper on FirestoreOrderUserModel {
  UserEntity toEntity() => UserEntity(lat: lat, lng: lng);
}

extension StoreMapper on FirestoreOrderStoreModel {
  StoreEntity toEntity() => StoreEntity(
    lat: lat,
    lng: lng,
    name: name,
    address: address,
    phoneNumber: phoneNumber??'',
    photo: image,
  );
}

