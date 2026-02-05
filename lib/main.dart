import 'package:easy_localization/easy_localization.dart';
import 'core/theme/app_colors.dart';
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

  // Initialize EasyLocalization BEFORE runApp
  await EasyLocalization.ensureInitialized();

  // Configure dependencies
  await configureDependencies();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // Set custom Bloc observer for debugging
  Bloc.observer = MyBlocObserver();

  // Set the status bar color to transparent and icons to white
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: AppColors.black,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.light,
    ),
  );

  await ScreenUtil.ensureScreenSize();

  //==================FOR WEB=====================
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
