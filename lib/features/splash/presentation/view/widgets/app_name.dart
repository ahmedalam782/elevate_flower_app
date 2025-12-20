
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/languages/locale_keys.g.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_typography.dart';
import '../../../../../core/theme/splash_theme.dart';

class AppName extends StatelessWidget {
  const AppName({
    super.key,
    required this.titleOpacity,
    required this.titleSlide,
  });
  final Animation<double> titleOpacity;
  final Animation<Offset> titleSlide;
  @override
  Widget build(BuildContext context) {
    final splashTheme = SplashTheme.of(context);

    return SlideTransition(
      position: titleSlide,
      child: FadeTransition(
        opacity: titleOpacity,
        child: ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              colors: [
                splashTheme.primaryColor,
                splashTheme.primaryColor.withValues(alpha: 0.8),
                splashTheme.primaryColor,
              ],
            ).createShader(bounds);
          },
          child: Text(
            LocaleKeys.global_app_name.tr(),
            style: 32.bold.copyWith(
              letterSpacing: 2,
              color: AppColors.whiteF9,
              shadows: [
                Shadow(
                  color: splashTheme.isDark ? Colors.black26 : Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
