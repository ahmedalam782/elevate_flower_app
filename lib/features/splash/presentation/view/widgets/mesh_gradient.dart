import 'package:flutter/material.dart';

import '../../../../../core/theme/splash_theme.dart';
import 'mesh_gradient_painter.dart';

class MeshGradient extends StatelessWidget {
  const MeshGradient({
    super.key,
    required this.size,
    required this.plusController,
  });
  final Size size;
  final AnimationController plusController;

  @override
  Widget build(BuildContext context) {
    final splashTheme = SplashTheme.of(context);
    return AnimatedBuilder(
      animation: plusController,
      builder: (context, child) {
        return CustomPaint(
          size: size,
          painter: MeshGradientPainter(
            progress: plusController.value,
            primaryColor: splashTheme.primaryColor,
            isDark: splashTheme.isDark,
          ),
        );
      },
    );
  }
}
