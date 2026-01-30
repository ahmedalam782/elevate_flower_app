import 'package:elevate_flower_app/features/user_addresses/domain/entities/user_address_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user_address_dto.g.dart';

@JsonSerializable()
class UserAddressDto {
  String? street;
  String? phone;
  String? city;
  String? lat;
  String? long;
  String? username;
  @JsonKey(name: "_id")
  String? id;

  UserAddressDto({
    this.street,
    this.phone,
    this.city,
    this.lat,
    this.long,
    this.username,
    this.id,
  });

  UserAddressEntity toEntity() {
    return UserAddressEntity(
      street: street,
      city: city,
      id: id,
      lat: lat,
      long: long,
      phone: phone,
      username: username,
    );
  }

  factory UserAddressDto.fromJson(Map<String, dynamic> json) =>
      _$UserAddressDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserAddressDtoToJson(this);
}
