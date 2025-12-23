import 'package:easy_localization/easy_localization.dart';
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
import 'core/theme/app_colors.dart';

const bool runLocal = false;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: AppColors.whiteF9,
      systemNavigationBarColor: AppColors.whiteF9,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
    ),
  );
  runApp(
    EasyLocalization(
      supportedLocales: [arabicLocale, englishLocale],
      fallbackLocale: englishLocale,
      startLocale: englishLocale,
      path: assetsLocalization,
      child: const FlowerApp(),
    ),
  );
  await configureDependencies(); // Set custom Bloc observer for debugging
  Bloc.observer = MyBlocObserver();
  await ScreenUtil.ensureScreenSize();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  //==================FOR WEB=====================
  GoRouter.optionURLReflectsImperativeAPIs = true;
  setPathUrlStrategy();
  await EasyLocalization.ensureInitialized();
}
