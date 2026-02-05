import '../../domain/entities/user_model_entity.dart';

import '../../domain/entities/login_response_entity.dart';
import 'login_response_model.dart';
import 'login_user_dto.dart';

extension LoginResponseModelMapper on LoginResponseModel {
  /// Convert Model to Entity
  LoginResponseEntity toEntity() {
    return LoginResponseEntity(
      message: message,
      token: token,
      user: user.toEntity(),
    );
  }
}

extension LoginUserDtoMapper on LoginUserDto {
  /// Convert DTO to Entity
  UserModelEntity toEntity() {
    return UserModelEntity(
      id: id,
      firstName: firstName,
      lastName: lastName,
      email: email,
      phone: phone,
      role: role,
      photo: photo,
      wishlist: wishlist,
      addresses: addresses,
      createdAt: createdAt,
    );
  }
}