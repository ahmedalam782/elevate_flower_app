import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class AddressDetailsData {
  final String? locationName;
  final String? userName;
  final String? city;
  final String? lat;
  final String? lng;
  final String? phone;
  AddressDetailsData({
    this.locationName,
    this.userName,
    this.city,
    this.lat,
    this.lng,
    this.phone,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'street': locationName,
      'phone': phone,
      'city': city,
      'lat': lat,
      'lng': lng,
      'username': userName,
    };
  }

  AddressDetailsData copyWith({
    String? locationName,
    String? userName,
    String? city,
    String? lat,
    String? lng,
    String? phone,
  }) {
    return AddressDetailsData(
      locationName: locationName ?? this.locationName,
      userName: userName ?? this.userName,
      city: city ?? this.city,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      phone: phone ?? this.phone,
    );
  }
}
