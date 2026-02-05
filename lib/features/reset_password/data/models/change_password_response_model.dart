import '../../domain/entities/change_password_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'change_password_response_model.g.dart';

@JsonSerializable()
class ChangePasswordResponseModel {
  final String message;
  final String? token;

  ChangePasswordResponseModel({required this.message, this.token});

  factory ChangePasswordResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ChangePasswordResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChangePasswordResponseModelToJson(this);

  ChangePasswordEntity toEntity() {
    return ChangePasswordEntity(message: message, token: token);
  }
}
