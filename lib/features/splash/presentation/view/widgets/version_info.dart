import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/languages/locale_keys.g.dart';
import '../../../../../core/theme/app_typography.dart';
import '../../../../../core/theme/splash_theme.dart';

class VersionInfo extends StatelessWidget {
  const VersionInfo({
    super.key,
    required this.textController,
    required this.textOpacity,
  });
  final AnimationController textController;
  final Animation<double> textOpacity;

  @override
  Widget build(BuildContext context) {
    final splashTheme = SplashTheme.of(context);

    return AnimatedBuilder(
      animation: textController,
      builder: (context, child) {
        return Opacity(
          opacity: textOpacity.value * 0.6,
          child: Text(
            '${LocaleKeys.global_version.tr()} 1.0.0',
            style: 11.regular.copyWith(
              color: splashTheme.subtitleColor,
              letterSpacing: 1,
            ),
          ),
        );
      },
    );
  }
}
