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













  // // Save access token
  // Future<void> saveAccessToken(String token) async {
  //   await _secureStorage.write(key: Apikeys.accessToken, value: token);
  //   log('✅ Access token saved');
  // }

  // // Save refresh token
  // Future<void> saveRefreshToken(String token) async {
  //   await _secureStorage.write(key: Apikeys.refreshToken, value: token);
  //   log('✅ Refresh token saved');
  // }

  // // Save user ID
  // Future<void> saveUserId(String userId) async {
  //   await _secureStorage.write(key: Apikeys.userId, value: userId);
  //   log('✅ User ID saved');
  // }

  // // Get refresh token
  // Future<String?> getRefreshToken() async {
  //   return await _secureStorage.read(key: Apikeys.refreshToken);
  // }

  // // Get user ID
  // Future<String?> getUserId() async {
  //   return await _secureStorage.read(key: Apikeys.userId);
  // }











  // Clear all tokens (logout)
  // Future<void> clearAllTokens() async {
  //   await _secureStorage.delete(key: Apikeys.accessToken);
  //   await _secureStorage.delete(key: Apikeys.refreshToken);
  //   await _secureStorage.delete(key: Apikeys.userId);

  //   log('🗑️ All tokens cleared');

  //   // ✅ Verify deletion
  //   // await _verifyTokensCleared();
  // }

   // Verify tokens are actually cleared
  // Future<void> _verifyTokensCleared() async {
  //   final accessToken = await getAccessToken();
  //   // final refreshToken = await getRefreshToken();
  //   // final userId = await getUserId();

  //   if (accessToken == null ) {
  //     log('✅ VERIFIED: All tokens successfully cleared');
  //   } else {
  //     log('⚠️ WARNING: Some tokens still exist!');
  //     log('Access Token: ${accessToken != null ? "EXISTS" : "null"}');
  //     // log('Refresh Token: ${refreshToken != null ? "EXISTS" : "null"}');
  //     // log('User ID: ${userId != null ? "EXISTS" : "null"}');
  //   }
  // }

  // Clear everything in secure storage
  // Future<void> clearAll() async {
  //   await _secureStorage.deleteAll();
  //   log('🗑️ All secure storage cleared');
  // }

  // Print current token status (for debugging)
  // Future<void> printTokenStatus() async {
  //   final accessToken = await getAccessToken();
    // final refreshToken = await getRefreshToken();
    // final userId = await getUserId();

    // log('📊 Token Status:');
    // log('Access Token: ${accessToken != null ? "EXISTS (${accessToken.substring(0, 20)}...)" : "NULL"}',);
    // log('  Refresh Token: ${refreshToken != null ? "EXISTS" : "NULL"}');
    // log('  User ID: ${userId ?? "NULL"}');
  //}
