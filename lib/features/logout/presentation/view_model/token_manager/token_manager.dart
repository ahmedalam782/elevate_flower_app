import 'dart:core';
import 'dart:developer';

import 'package:elevate_flower_app/core/config/api/end_points.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class TokenManager {
  final FlutterSecureStorage _secureStorage;

  TokenManager(this._secureStorage);


  // Get access token
  Future<String?> getAccessToken() async {
    return await _secureStorage.read(key: Apikeys.accessToken);
  }


  // Check if user is authenticated
  Future<bool> isAuthenticated() async {
    final token = await getAccessToken();
    final isAuth = token != null && token.isNotEmpty;
    log('🔍 User authenticated: $isAuth');
    return isAuth;
  }

}












