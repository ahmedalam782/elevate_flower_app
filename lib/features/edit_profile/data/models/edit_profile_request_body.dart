import '../../domain/entities/edit_profile_params.dart';
import 'package:json_annotation/json_annotation.dart';

part 'edit_profile_request_body.g.dart';

@JsonSerializable(includeIfNull: false, createFactory: false)
class EditProfileRequestBody {
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phone;
  final String? password;
  final String? gender;
  final String? photo;

  EditProfileRequestBody({
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.password,
    this.gender,
    this.photo,
  });

  Map<String, dynamic> toJson() => _$EditProfileRequestBodyToJson(this);
  factory EditProfileRequestBody.fromEntity(EditProfileParams params) {
    return EditProfileRequestBody(
      firstName: params.firstName,
      lastName: params.lastName,
      email: params.email,
      phone: params.phoneNumber,
      gender: params.gender,
    );
  }
}
