import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../../core/theme/splash_theme.dart';


/// Animated floating particle widget
class FloatingParticle extends StatelessWidget {
  final Animation<double> animation;
  final int index;
  final Size size;

  const FloatingParticle({
    super.key,
    required this.animation,
    required this.index,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    final splashTheme = SplashTheme.of(context);
    final positions = [
      Offset(size.width * 0.15, size.height * 0.2),
      Offset(size.width * 0.85, size.height * 0.35),
      Offset(size.width * 0.1, size.height * 0.7),
      Offset(size.width * 0.9, size.height * 0.75),
      Offset(size.width * 0.5, size.height * 0.15),
    ];

    final sizes = [6.0, 8.0, 5.0, 7.0, 4.0];
    return Positioned(
      left: positions[index].dx,
      top: positions[index].dy,
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          final offset = math.sin(animation.value * math.pi * 2 + index) * 10;
          final opacity =
              0.3 + (math.sin(animation.value * math.pi * 2 + index) * 0.2);
          return Transform.translate(
            offset: Offset(0, offset),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              width: sizes[index],
              height: sizes[index],
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: splashTheme.particleColor(opacity),
              ),
            ),
          );
        },
      ),
    );
  }
}
