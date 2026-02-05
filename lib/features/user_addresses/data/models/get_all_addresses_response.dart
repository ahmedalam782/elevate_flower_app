import 'user_address_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_all_addresses_response.g.dart';

@JsonSerializable()
class GetAllAddressesResponse {
  final String? message;
  final List<UserAddressDto>? addresses;

  GetAllAddressesResponse({this.message, this.addresses});

  factory GetAllAddressesResponse.fromJson(Map<String, dynamic> json) =>
      _$GetAllAddressesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllAddressesResponseToJson(this);
}
