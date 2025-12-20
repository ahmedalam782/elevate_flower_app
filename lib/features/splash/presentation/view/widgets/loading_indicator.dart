import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../../core/languages/locale_keys.g.dart';
import '../../../../../core/theme/splash_theme.dart';
import 'animated_progress_bar.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({
    super.key,
    required this.loadingController,
    required this.textController,
    required this.textOpacity,
  });
  final AnimationController loadingController;
  final AnimationController textController;
  final Animation<double> textOpacity;

  @override
  Widget build(BuildContext context) {
    final splashTheme = SplashTheme.of(context);

    return AnimatedBuilder(
      animation: textController,
      builder: (context, child) {
        return Opacity(
          opacity: textOpacity.value,
          child: Column(
            children: [
              // Progress bar style loader
              AnimatedProgressBar(animation: loadingController),
              const SizedBox(height: 16),
              // Loading text
              Text(
                LocaleKeys.global_loading.tr(),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: splashTheme.subtitleColor,
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
