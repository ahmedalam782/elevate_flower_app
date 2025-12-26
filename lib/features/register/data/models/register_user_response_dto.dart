import 'package:elevate_flower_app/features/register/data/models/register_user_model.dart';
import 'package:elevate_flower_app/features/register/domain/entities/register_user_response.dart';
import 'package:json_annotation/json_annotation.dart';
part 'register_user_response_dto.g.dart';

@JsonSerializable()
class RegisterUserResponseDto {
    @JsonKey(name: "message")
    String? message;
    @JsonKey(name: "user")
    User? user;
    @JsonKey(name: "token")
    String? token;

    RegisterUserResponseDto({
        this.message,
        this.user,
        this.token,
    });

    factory RegisterUserResponseDto.fromJson(Map<String, dynamic> json) => _$RegisterUserResponseDtoFromJson(json);

    Map<String, dynamic> toJson() => _$RegisterUserResponseDtoToJson(this);

    RegisterUserResponse toEntity() {
      return RegisterUserResponse(
        message: message,
        token: token,
      );
    }
}

