import 'package:json_annotation/json_annotation.dart';

part 'login_user_dto.g.dart';

@JsonSerializable()
class LoginUserDto {
  @JsonKey(name: '_id')
  final String id;

  final String firstName;
  final String lastName;
  final String email;
  final String gender;
  final String phone;
  final String photo;
  final String role;

  final List<dynamic> wishlist;
  final List<dynamic> addresses;

  final String createdAt;

  LoginUserDto({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.gender,
    required this.phone,
    required this.photo,
    required this.role,
    required this.wishlist,
    required this.addresses,
    required this.createdAt,
  });

  factory LoginUserDto.fromJson(Map<String, dynamic> json) =>
      _$LoginUserDtoFromJson(json);

  Map<String, dynamic> toJson() => _$LoginUserDtoToJson(this);
}