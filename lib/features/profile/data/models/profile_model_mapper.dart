import '../../domain/entities/profile_data_entity.dart';
import 'profile_data_model.dart';
import 'profile_response_model.dart';

extension ProfileDataModelMapper on ProfileDataModel {
  ProfileDataEntity toEntity() {
    return ProfileDataEntity(
      id: id,
      firstName: firstName,
      lastName: lastName,
      email: email,
      gender: gender,
      phone: phone,
      photo: photo,
      role: role,
      wishlist: wishlist,
      addresses: addresses,
      createdAt: createdAt,
    );
  }
}

extension ProfileResponseModelMapper on ProfileResponseModel {
  ProfileDataEntity toEntity() {
    return user.toEntity();
  }
}
