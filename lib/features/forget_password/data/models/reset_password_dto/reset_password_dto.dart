import 'package:json_annotation/json_annotation.dart';
part 'reset_password_dto.g.dart';

@JsonSerializable()
class ResetPasswordDTo {
  @JsonKey(name: "email")
  String email;
  @JsonKey(name: "newPassword")
  String newPassword;

  ResetPasswordDTo({required this.email, required this.newPassword});

  factory ResetPasswordDTo.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordDToFromJson(json);

  Map<String, dynamic> toJson() => _$ResetPasswordDToToJson(this);
}
