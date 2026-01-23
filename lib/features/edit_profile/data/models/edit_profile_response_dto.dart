import 'package:elevate_flower_app/features/edit_profile/data/models/edit_profile_user_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'edit_profile_response_dto.g.dart';
@JsonSerializable()
class EditProfileResponseDto {
  EditProfileResponseDto({
    this.message,
    this.user,
  });

  String? message;
  EditProfileUserDto? user;
  factory EditProfileResponseDto.fromJson(Map<String, dynamic> json) => _$EditProfileResponseDtoFromJson(json);
  Map<String, dynamic> toJson() => _$EditProfileResponseDtoToJson(this);
 
}