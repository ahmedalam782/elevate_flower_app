import 'package:json_annotation/json_annotation.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
part 'address_details_data.g.dart';

@JsonSerializable()
class AddressDetailsData {
  @JsonKey(includeToJson: false, includeFromJson: false)
  final String? addressId;
  final String? street;
  final String? username;
  final String? city;
  final String? lat;
  final String? long;
  final String? phone;
  AddressDetailsData({
    this.street,
    this.username,
    this.city,
    this.lat,
    this.long,
    this.phone,
    this.addressId,
  });

  factory AddressDetailsData.fromJson(Map<String, dynamic> json) =>
      _$AddressDetailsDataFromJson(json);

  Map<String, dynamic> toJson() => _$AddressDetailsDataToJson(this);
  AddressDetailsData copyWith({
    String? street,
    String? userName,
    String? city,
    String? lat,
    String? lng,
    String? phone,
  }) {
    return AddressDetailsData(
      street: street ?? this.street,
      username: userName ?? this.username,
      city: city ?? this.city,
      lat: lat ?? this.lat,
      long: lng ?? this.long,
      phone: phone ?? this.phone,
    );
  }
}
