import 'package:json_annotation/json_annotation.dart';

part 'login_request_model.g.dart';

@JsonSerializable()
class LoginRequestModel {
  final String email;
  final String password;
  LoginRequestModel({required this.email, required this.password});

  Map<String, dynamic> toJson() => _$LoginRequestModelToJson(this);

  factory LoginRequestModel.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestModelFromJson(json);
}