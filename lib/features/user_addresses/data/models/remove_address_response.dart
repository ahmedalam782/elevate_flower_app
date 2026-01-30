import 'package:elevate_flower_app/features/user_addresses/data/models/user_address_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remove_address_response.g.dart';

@JsonSerializable()
class RemoveAddressResponse {
  final String? message;
  final List<UserAddressDto>? address;

  RemoveAddressResponse({this.message, this.address});

  factory RemoveAddressResponse.fromJson(Map<String, dynamic> json) =>
      _$RemoveAddressResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RemoveAddressResponseToJson(this);
}
