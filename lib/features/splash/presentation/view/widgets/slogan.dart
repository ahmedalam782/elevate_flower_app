import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/languages/locale_keys.g.dart';
import '../../../../../core/theme/app_typography.dart';
import '../../../../../core/theme/splash_theme.dart';


class Slogan extends StatelessWidget {
  const Slogan({super.key, required this.textOpacity, required this.textSlide});
  final Animation<double> textOpacity;
  final Animation<Offset> textSlide;

  @override
  Widget build(BuildContext context) {
    final splashTheme = SplashTheme.of(context);

    return SlideTransition(
      position: textSlide,
      child: FadeTransition(
        opacity: textOpacity,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          margin: const EdgeInsets.symmetric(horizontal: 32),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: splashTheme.sloganBackground,
            border: Border.all(color: splashTheme.sloganBorder, width: 1),
          ),
          child: Text(
            LocaleKeys.global_app_slogan.tr(),
            textAlign: TextAlign.center,
            style: 14.medium.copyWith(
              color: splashTheme.subtitleColor,
              height: 1.5,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
    );
  }
}
