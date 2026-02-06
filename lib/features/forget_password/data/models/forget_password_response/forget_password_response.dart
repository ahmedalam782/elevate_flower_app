import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/forget_password_entity/forget_password_entity.dart';

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
