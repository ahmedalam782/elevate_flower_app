import '../../domain/entities/address_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user_addresses_response.g.dart';

@JsonSerializable()
class UserAddressesResponse {
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'addresses')
  List<Addresses>? addresses;

  UserAddressesResponse({this.message, this.addresses});

  factory UserAddressesResponse.fromJson(Map<String, dynamic> json) =>
      _$UserAddressesResponseFromJson(json);

  static List<UserAddressesResponse> fromList(List<Map<String, dynamic>> list) {
    return list.map(UserAddressesResponse.fromJson).toList();
  }

  Map<String, dynamic> toJson() => _$UserAddressesResponseToJson(this);
}

@JsonSerializable()
class Addresses {
  @JsonKey(name: 'street')
  String? street;
  @JsonKey(name: 'phone')
  String? phone;
  @JsonKey(name: 'city')
  String? city;
  @JsonKey(name: 'lat')
  String? lat;
  @JsonKey(name: 'long')
  String? long;
  @JsonKey(name: 'username')
  String? username;
  @JsonKey(name: '_id')
  String? id;

  Addresses({
    this.street,
    this.phone,
    this.city,
    this.lat,
    this.long,
    this.username,
    this.id,
  });

  factory Addresses.fromJson(Map<String, dynamic> json) =>
      _$AddressesFromJson(json);

  static List<Addresses> fromList(List<Map<String, dynamic>> list) {
    return list.map(Addresses.fromJson).toList();
  }

  Map<String, dynamic> toJson() => _$AddressesToJson(this);
}

extension AddressesExtension on Addresses {
  AddressEntity toEntity() {
    return AddressEntity(
      street: street,
      city: city,
      lat: lat,
      long: long,
      id: id,
      phone: phone,
    );
  }
}
