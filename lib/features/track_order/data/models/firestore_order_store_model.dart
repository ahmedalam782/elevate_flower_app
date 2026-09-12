import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreOrderStoreModel {
  final String? id;
  final String image;
  final num lat;
  final num lng;
  final String name;
  final String address;
  final String? phoneNumber;

  const FirestoreOrderStoreModel({
    this.id,
    required this.image,
    required this.lat,
    required this.lng,
    required this.name,
    required this.address,
    this.phoneNumber,
  });

  FirestoreOrderStoreModel copyWith({
    String? id,
    String? image,
    num? lat,
    num? lng,
    String? name,
    String? address,
    String? phoneNumber,
  }) {
    return FirestoreOrderStoreModel(
      id: id ?? this.id,
      image: image ?? this.image,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      name: name ?? this.name,
      address: address ?? this.address,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  factory FirestoreOrderStoreModel.fromJson(Map<String, dynamic> json) {
    return FirestoreOrderStoreModel(
      id: json['id']?.toString(),
      image: (json['image'] ?? '').toString(),
      lat: _parseCoordinate(json['lat']),
      lng: _parseCoordinate(json['lng']),
      name: (json['name'] ?? '').toString(),
      address: (json['address'] ?? '').toString(),
      phoneNumber: (json['phoneNumber'] ?? '').toString(),
    );
  }

  factory FirestoreOrderStoreModel.fromDocument(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    final data = document.data();
    if (data == null) {
      throw StateError('Store document ${document.id} has no data.');
    }

    return FirestoreOrderStoreModel.fromJson({
      ...data,
      'id': data['id'] ?? document.id,
    });
  }

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'lat': lat,
      'lng': lng,
      'name': name,
      'address': address,
      'phoneNumber': phoneNumber,
    };
  }

  static num _parseCoordinate(dynamic value) {
    if (value is num) {
      return value;
    }

    if (value is String) {
      return num.tryParse(value) ?? 0;
    }

    return 0;
  }
}

class FirestoreStoreLocationModel {
  final num lat;
  final num lng;

  const FirestoreStoreLocationModel({required this.lat, required this.lng});

  FirestoreStoreLocationModel copyWith({num? lat, num? lng}) {
    return FirestoreStoreLocationModel(
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
    );
  }

  factory FirestoreStoreLocationModel.fromJson(Map<String, dynamic> json) {
    return FirestoreStoreLocationModel(
      lat: FirestoreOrderStoreModel._parseCoordinate(json['lat']),
      lng: FirestoreOrderStoreModel._parseCoordinate(json['lng']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'lat': lat, 'lng': lng};
  }
}
