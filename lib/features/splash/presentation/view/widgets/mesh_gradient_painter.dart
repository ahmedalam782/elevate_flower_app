import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Mesh gradient painter for premium animated background
class MeshGradientPainter extends CustomPainter {
  final double progress;
  final Color primaryColor;
  final int pointCount;
  final double maxRadius;
  final bool isDark;

  MeshGradientPainter({
    required this.progress,
    required this.primaryColor,
    this.pointCount = 5,
    this.maxRadius = 0.4,
    this.isDark = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Adjust opacity based on theme
    final baseOpacity = isDark ? 0.06 : 0.03;
    final fadeOpacity = isDark ? 0.03 : 0.01;

    // Create subtle mesh gradient points
    final points = [
      Offset(size.width * 0.2, size.height * 0.1),
      Offset(size.width * 0.8, size.height * 0.2),
      Offset(size.width * 0.1, size.height * 0.6),
      Offset(size.width * 0.9, size.height * 0.7),
      Offset(size.width * 0.5, size.height * 0.9),
    ];

    for (int i = 0; i < points.length; i++) {
      final point = points[i];
      final offset = math.sin(progress * math.pi * 2 + i) * 20;
      final adjustedPoint = Offset(point.dx + offset, point.dy);

      paint.shader =
          RadialGradient(
            center: Alignment.center,
            radius: 1.0,
            colors: [
              primaryColor.withValues(alpha: baseOpacity),
              primaryColor.withValues(alpha: fadeOpacity),
              Colors.transparent,
            ],
            stops: const [0.0, 0.5, 1.0],
          ).createShader(
            Rect.fromCircle(
              center: adjustedPoint,
              radius: size.width * maxRadius,
            ),
          );

      canvas.drawCircle(adjustedPoint, size.width * maxRadius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant MeshGradientPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.primaryColor != primaryColor ||
        oldDelegate.isDark != isDark;
  }
}
