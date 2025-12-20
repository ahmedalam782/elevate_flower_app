import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../../core/theme/splash_theme.dart';


class Particles extends StatelessWidget {
  const Particles({
    super.key,
    required this.index,
    required this.particleController,
    required this.size,
  });

  final int index;
  final Animation<double> particleController;
  final Size size;

  @override
  Widget build(BuildContext context) {
    final splashTheme = SplashTheme.of(context);
    final random = math.Random(index);
    final startX = random.nextDouble() * size.width;
    final startY = random.nextDouble() * size.height;
    final particleSize = 2.0 + random.nextDouble() * 4;
    return Positioned(
      left: startX,
      top: startY,
      child: AnimatedBuilder(
        animation: particleController,
        builder: (context, child) {
          final progress = (particleController.value + index * 0.08) % 1.0;
          final yOffset = -50 * progress;
          final xOffset = math.sin(progress * math.pi * 2) * 20;
          final opacity = (1 - progress) * 0.4;

          return Transform.translate(
            offset: Offset(xOffset, yOffset),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              width: particleSize,
              height: particleSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: splashTheme.particleColor(opacity),
                boxShadow: [
                  BoxShadow(
                    color: splashTheme.particleColor(opacity * 0.5),
                    blurRadius: particleSize * 2,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
