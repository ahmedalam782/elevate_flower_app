import 'package:easy_localization/easy_localization.dart';
import 'package:elevate_flower_app/features/change_lang/domain/use_cases/get_lang_use_case.dart';
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
  await configureDependencies(); 
  final currentLang = await getIt<GetLangUseCase>().call();
  runApp(
    EasyLocalization(
      supportedLocales: const [arabicLocale, englishLocale],
      fallbackLocale: englishLocale,
      startLocale: currentLang.when(
        success: (data) =>
            (data ?? "en") == "en" ? englishLocale : arabicLocale,
        error: (exception) {
          return englishLocale;
        },
      ),
      path: assetsLocalization,
      saveLocale: true,
      child: const FlowerApp(),
    ),
  );
  Bloc.observer = MyBlocObserver();
  await ScreenUtil.ensureScreenSize();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  //==================FOR WEB=====================
  GoRouter.optionURLReflectsImperativeAPIs = true;
  setPathUrlStrategy();
  await EasyLocalization.ensureInitialized();
}
