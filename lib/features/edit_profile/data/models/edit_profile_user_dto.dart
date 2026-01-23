
import 'package:elevate_flower_app/features/edit_profile/domain/entities/edit_profile_user_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'edit_profile_user_dto.g.dart';
@JsonSerializable()
class EditProfileUserDto {
  @JsonKey(name: '_id')
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? password;
  final String? gender;
  final String? phone;
  final String? photo;
  final String? role;
  final String? createdAt;

  EditProfileUserDto({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.gender,
    this.phone,
    this.photo,
    this.role,
    this.createdAt,
  });

factory EditProfileUserDto.fromJson(Map<String, dynamic> json) => _$EditProfileUserDtoFromJson(json);
  Map<String, dynamic> toJson() => _$EditProfileUserDtoToJson(this);

  EditProfileUserEntity toEntity() => EditProfileUserEntity(
    id: id,
    firstName: firstName,
    lastName: lastName,
    email: email,
    password: password,
    gender: gender,
    phoneNumber: phone,
    image: photo
  );
}