import 'package:flutter/material.dart';

import '../../../../../core/theme/splash_theme.dart';


/// Animated progress bar loader
class AnimatedProgressBar extends StatelessWidget {
  final Animation<double> animation;
  final double width;
  final double height;
  final Color? color;

  const AnimatedProgressBar({
    super.key,
    required this.animation,
    this.width = 160,
    this.height = 3,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final splashTheme = SplashTheme.of(context);
    final barColor = color ?? splashTheme.primaryColor;
    final trackOpacity = splashTheme.isDark ? 0.15 : 0.1;
    final glowOpacity = splashTheme.isDark ? 0.7 : 0.5;

    return AnimatedContainer(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(height / 2),
        color: barColor.withValues(alpha: trackOpacity),
      ),
      duration: const Duration(milliseconds: 300),
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          return FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: 0.3,
            child: Transform.translate(
              offset: Offset(width * 0.7 * animation.value, 0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(height / 2),
                  gradient: LinearGradient(
                    colors: [
                      barColor.withValues(alpha: 0.3),
                      barColor,
                      barColor.withValues(alpha: 0.3),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: barColor.withValues(alpha: glowOpacity),
                      blurRadius: splashTheme.isDark ? 8 : 6,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
