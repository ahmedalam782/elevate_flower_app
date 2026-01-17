import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/app_interceptor.dart';
import '../api/end_points.dart';

@module
abstract class CoreInjectableModule {
  @preResolve
  Future<SharedPreferences> prefs() => SharedPreferences.getInstance();

  static AndroidOptions _getAndroidOptions() =>
      const AndroidOptions().copyWith(encryptedSharedPreferences: true);
  @lazySingleton
  FlutterSecureStorage secureStorage() =>
      FlutterSecureStorage(aOptions: _getAndroidOptions());

  @singleton
  Dio dio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: EndPoints.baseUrl,
        sendTimeout: const Duration(seconds: 45),
        connectTimeout: const Duration(seconds: 45),
      ),
    );
    dio.interceptors.add(AppInterceptors(dio: dio, fss: secureStorage()));
    dio.interceptors.addAll([
      if (kDebugMode)
        PrettyDioLogger(
          request: true,
          requestBody: true,
          responseHeader: true,
          responseBody: true,
          error: true,
          compact: true,
          requestHeader: true,
        ),
    ]);
    return dio;
  }

  @lazySingleton
  CancelToken cancelToken() => CancelToken();

  @lazySingleton
  InternetConnection internetConnection() => InternetConnection();
}
