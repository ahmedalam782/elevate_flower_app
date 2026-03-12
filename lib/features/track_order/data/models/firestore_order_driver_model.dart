import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreOrderDriverModel {
  final String id;
  final String firstName;
  final String lastName;
  final num lat;
  final num lng;
  final String phoneNumber;
  final String photo;

  const FirestoreOrderDriverModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.lat,
    required this.lng,
    required this.phoneNumber,
    required this.photo,
  });

  FirestoreOrderDriverModel copyWith({
    String? id,
    String? firstName,
    String? lastName,
    num? lat,
    num? lng,
    String? phoneNumber,
    String? photo,
  }) {
    return FirestoreOrderDriverModel(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      photo: photo ?? this.photo,
    );
  }

  FirestoreDriverLocationModel get location =>
      FirestoreDriverLocationModel(lat: lat, lng: lng);

  factory FirestoreOrderDriverModel.fromJson(Map<String, dynamic> json) {
    return FirestoreOrderDriverModel(
      id: (json['id'] ?? '').toString(),
      firstName: (json['firstName'] ?? '').toString(),
      lastName: (json['lastName'] ?? '').toString(),
      lat: _parseCoordinate(json['lat']),
      lng: _parseCoordinate(json['lng']),
      phoneNumber: (json['phoneNumber'] ?? '').toString(),
      photo: (json['photo'] ?? '').toString(),
    );
  }

  factory FirestoreOrderDriverModel.fromDocument(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    final data = document.data();
    if (data == null) {
      throw StateError('Driver document ${document.id} has no data.');
    }

    return FirestoreOrderDriverModel.fromJson({
      ...data,
      'id': data['id'] ?? document.id,
    });
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'lat': lat,
      'lng': lng,
      'phoneNumber': phoneNumber,
      'photo': photo,
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

class FirestoreDriverLocationModel {
  final num lat;
  final num lng;

  const FirestoreDriverLocationModel({
    required this.lat,
    required this.lng,
  });

  FirestoreDriverLocationModel copyWith({
    num? lat,
    num? lng,
  }) {
    return FirestoreDriverLocationModel(
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
    );
  }

  factory FirestoreDriverLocationModel.fromJson(Map<String, dynamic> json) {
    return FirestoreDriverLocationModel(
      lat: FirestoreOrderDriverModel._parseCoordinate(json['lat']),
      lng: FirestoreOrderDriverModel._parseCoordinate(json['lng']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'lng': lng,
    };
  }
}
