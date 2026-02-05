
import '../../domain/entities/register_params.dart';
import 'package:json_annotation/json_annotation.dart';
part 'register_request_body.g.dart';

@JsonSerializable()
class RegisterRequestBody {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  @JsonKey(name: 'rePassword')
  final String passwordConfirmation;
  @JsonKey(name: 'phone')
  final String phoneNumber;
  final String gender;
 
  RegisterRequestBody({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.passwordConfirmation,
    required this.phoneNumber,
    required this.gender,
  });

  factory RegisterRequestBody.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestBodyFromJson(json);
  Map<String, dynamic> toJson() => _$RegisterRequestBodyToJson(this);

  factory RegisterRequestBody.fromEntity(RegisterParams params) {
    return RegisterRequestBody(
      firstName: params.firstName,
      lastName: params.lastName,
      email: params.email,
      password: params.password,
      passwordConfirmation: params.passwordConfirmation,
      phoneNumber: params.phoneNumber,
      gender: params.gender,
    );
  }
}
