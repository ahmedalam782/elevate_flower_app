import 'package:easy_localization/easy_localization.dart';
import 'package:elevate_flower_app/core/fcm/fcm_config.dart';
import 'package:elevate_flower_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'app.dart';
import 'core/config/di/injectable_config.dart';
import 'core/helper/bloc/bloc_observer.dart';
import 'core/languages/lang.dart';
import 'core/routes/url_strategy.dart';

const bool runLocal = false;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Future.wait([
    Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform),
    EasyLocalization.ensureInitialized(),
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]),
    ScreenUtil.ensureScreenSize(),
    configureDependencies(),
  ]);

  FCMService().initialize();

  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  //Disable crashlytics in debug =>
  await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);

  // Set custom Bloc observer for debugging
  Bloc.observer = MyBlocObserver();

  //!==================FOR WEB=====================
  GoRouter.optionURLReflectsImperativeAPIs = true;
  setPathUrlStrategy();

  runApp(
    EasyLocalization(
      supportedLocales: const [arabicLocale, englishLocale],
      fallbackLocale: englishLocale,
      path: assetsLocalization,
      saveLocale: true,
      child: const FlowerApp(),
    ),
  );
}
