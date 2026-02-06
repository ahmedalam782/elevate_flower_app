import 'dart:developer';

import '../../config/api/end_points.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/di/injectable_config.dart';
import '../../routes/app_router.dart';
import '../../routes/routes.dart';

abstract class UserHelper {
  static final FlutterSecureStorage _secureStorage =
      getIt<FlutterSecureStorage>();
  static final SharedPreferences _sharedPreferences = getIt
      .get<SharedPreferences>();

  static Future<bool> isLogin() async =>
      (await _secureStorage.read(key: Apikeys.accessToken)) != null;
      
  static Future<bool?> isRememberMe() async =>
      _sharedPreferences.getBool(Apikeys.rememberMe);
  static Future<void> clearUserData() async {
    _sharedPreferences.clear();
    await _secureStorage.deleteAll();
    await DefaultCacheManager().emptyCache();
    log('mayar<<<<<<<<<<<<<<<<<<<<<<<<<<');
    // FirebaseUnsubscribe.unsubscribeFromTopics();
    router.go(Routes.login);
  }
}
