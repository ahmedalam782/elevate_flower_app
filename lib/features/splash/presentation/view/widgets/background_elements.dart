import 'package:flutter/material.dart';

import '../../../../../core/theme/splash_theme.dart';

class TopRightDecorativeCircle extends StatelessWidget {
  const TopRightDecorativeCircle({
    super.key,
    required this.pulseController,
    required this.size,
  });
  final Animation<double> pulseController;
  final Size size;

  @override
  Widget build(BuildContext context) {
    final splashTheme = SplashTheme.of(context);
    return Positioned(
      top: -size.width * 0.3,
      right: -size.width * 0.3,
      child: AnimatedBuilder(
        animation: pulseController,
        builder: (context, child) {
          final scale = 1.0 + (pulseController.value * 0.05);
          return Transform.scale(
            scale: scale,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              width: size.width * 0.8,
              height: size.width * 0.8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: splashTheme.decorativeGradient,
                  stops: const [0.0, 0.5, 1.0],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class BottomLeftDecorativeCircle extends StatelessWidget {
  const BottomLeftDecorativeCircle({
    super.key,
    required this.pulseController,
    required this.size,
  });
  final Animation<double> pulseController;
  final Size size;

  @override
  Widget build(BuildContext context) {
    final splashTheme = SplashTheme.of(context);
    return Positioned(
      bottom: -size.width * 0.25,
      left: -size.width * 0.25,
      child: AnimatedBuilder(
        animation: pulseController,
        builder: (context, child) {
          final scale = 1.0 + ((1 - pulseController.value) * 0.05);
          return Transform.scale(
            scale: scale,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              width: size.width * 0.7,
              height: size.width * 0.7,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: splashTheme.decorativeGradient,
                  stops: const [0.0, 0.5, 1.0],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
