import 'package:cloud_firestore/cloud_firestore.dart';

class TrackOrderEntity {
  final String id;
  final String paymentType;
  final String state;
  final double totalPrice;
  final Timestamp? acceptedAt;
  final Timestamp? arrivedAtPickUpAt;
  final Timestamp? deliveringAt;
  final Timestamp? deliveredAt;
  final Timestamp? completedAt;

  final DriverEntity driver;
  final UserEntity user;
  final StoreEntity store;  
  const TrackOrderEntity({
    required this.id,
    required this.paymentType,
    required this.state,
    required this.totalPrice,
    required this.acceptedAt,
    required this.arrivedAtPickUpAt,
    required this.deliveringAt,
    required this.deliveredAt,
    required this.completedAt,
    required this.driver,
    required this.user,
    required this.store,
  });
}

class DriverEntity {
  final String id;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String photo;
  final String vehicleImage;
  final DriverLocationEntity location;

  const DriverEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.photo,
    required this.vehicleImage,
    required this.location,
  });
}

class DriverLocationEntity {
  final double lat;
  final double lng;

  const DriverLocationEntity({required this.lat, required this.lng});
}

class UserEntity {
  final double lat;
  final double lng;

  const UserEntity({required this.lat, required this.lng});
}

class StoreEntity {
  final String name;
  final String address;
  final String phoneNumber;
  final String photo;
  final double lat;
  final double lng;

  const StoreEntity({
    required this.lat,
    required this.lng,
    required this.name,
    required this.address,
    required this.phoneNumber,
    required this.photo,
  });
}
