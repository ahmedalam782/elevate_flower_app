import 'package:elevate_flower_app/features/forget-password/domain/entities/forget_password_entity/forget_password_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'forget_password_response.g.dart';

@JsonSerializable()
class ForgetPasswordResponse {
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "info")
  String? info;

  ForgetPasswordResponse({this.message, this.info});

  factory ForgetPasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$ForgetPasswordResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ForgetPasswordResponseToJson(this);

  ForgetPasswordEntity toForgetPasswordEntity() {
    return ForgetPasswordEntity(info: info ?? "", message: message ?? "");
  }
}
