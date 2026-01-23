import 'package:json_annotation/json_annotation.dart';

part 'profile_data_model.g.dart';

@JsonSerializable()
class ProfileDataModel {
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

  ProfileDataModel({
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

  factory ProfileDataModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileDataModelToJson(this);
}
