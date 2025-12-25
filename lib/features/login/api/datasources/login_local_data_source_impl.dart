import 'package:elevate_flower_app/features/login/data/datasources/login_local_data_source_contract.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/config/api/end_points.dart';

@LazySingleton(as: LoginLocalDataSourceContract)
class LoginLocalDataSourceImpl implements LoginLocalDataSourceContract {
  final FlutterSecureStorage secureStorage;
  final SharedPreferences sharedPreferences;

  LoginLocalDataSourceImpl({
    required this.secureStorage,
    required this.sharedPreferences,
  });

  @override
  Future<void> saveToken(String token) async {
    await secureStorage.write(key: Apikeys.accessToken, value: token);
  }

  @override
  Future<void> saveUserId(String userId) async {
    await secureStorage.write(key: Apikeys.userId, value: userId);
  }

  @override
  Future<void> saveRememberMe(bool rememberMe) async {
    await sharedPreferences.setBool(Apikeys.rememberMe, rememberMe);
  }

  @override
  Future<String?> getToken() async {
    return await secureStorage.read(key: Apikeys.accessToken);
  }

  @override
  Future<String?> getUserId() async {
    return await secureStorage.read(key: Apikeys.userId);
  }

  @override
  Future<bool> getRememberMe() async {
    return sharedPreferences.getBool(Apikeys.rememberMe) ?? false;
  }

  @override
  Future<void> clearLoginData() async {
    await secureStorage.delete(key: Apikeys.accessToken);
    await secureStorage.delete(key: Apikeys.userId);
    await sharedPreferences.remove(Apikeys.rememberMe);
  }
}