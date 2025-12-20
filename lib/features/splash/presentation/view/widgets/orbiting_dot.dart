import 'dart:math' as math;
import 'package:flutter/material.dart';

import '../../../../../core/theme/splash_theme.dart';


/// Orbiting dot widget for logo decoration
class OrbitingDot extends StatelessWidget {
  final Animation<double> animation;
  final int index;
  final double radius;
  final double dotSize;
  final Color? color;

  const OrbitingDot({
    super.key,
    required this.animation,
    required this.index,
    this.radius = 115.0,
    this.dotSize = 6.0,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final splashTheme = SplashTheme.of(context);
    final dotColor = color ?? splashTheme.primaryColor;
    final angles = [0.0, 2 * math.pi / 3, 4 * math.pi / 3];
    final sizes = [6.0, 5.0, 4.0];

    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final angle = angles[index] + (animation.value * 2 * math.pi);
        final x = math.cos(angle) * radius;
        final y = math.sin(angle) * radius;

        return Transform.translate(
          offset: Offset(x, y),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            width: sizes[index],
            height: sizes[index],
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: dotColor,
              boxShadow: [
                BoxShadow(
                  color: dotColor.withValues(
                    alpha: splashTheme.isDark ? 0.7 : 0.5,
                  ),
                  blurRadius: splashTheme.isDark ? 10 : 8,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
