import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/datasources/profile_local_data_source_contract.dart';
import '../../domain/entities/profile_data_entity.dart';

@Injectable(as: ProfileLocalDataSourceContract)
class ProfileLocalDataSourceImpl implements ProfileLocalDataSourceContract {
  final SharedPreferences _sharedPreferences;
  static const String _profileKey = 'cached_profile_data';

  ProfileLocalDataSourceImpl(this._sharedPreferences);

  @override
  Future<void> saveProfileData(ProfileDataEntity profile) async {
    final profileMap = {
      'id': profile.id,
      'firstName': profile.firstName,
      'lastName': profile.lastName,
      'email': profile.email,
      'gender': profile.gender,
      'phone': profile.phone,
      'photo': profile.photo,
      'role': profile.role,
      'wishlist': profile.wishlist,
      'addresses': profile.addresses,
      'createdAt': profile.createdAt,
    };
    await _sharedPreferences.setString(_profileKey, json.encode(profileMap));
  }

  @override
  Future<ProfileDataEntity?> getProfileData() async {
    final profileString = _sharedPreferences.getString(_profileKey);
    if (profileString == null) return null;

    try {
      final profileMap = json.decode(profileString) as Map<String, dynamic>;
      return ProfileDataEntity(
        id: profileMap['id'] as String,
        firstName: profileMap['firstName'] as String,
        lastName: profileMap['lastName'] as String,
        email: profileMap['email'] as String,
        gender: profileMap['gender'] as String,
        phone: profileMap['phone'] as String,
        photo: profileMap['photo'] as String,
        role: profileMap['role'] as String,
        wishlist: profileMap['wishlist'] as List<dynamic>,
        addresses: profileMap['addresses'] as List<dynamic>,
        createdAt: profileMap['createdAt'] as String,
      );
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> clearProfileData() async {
    await _sharedPreferences.remove(_profileKey);
  }
}
