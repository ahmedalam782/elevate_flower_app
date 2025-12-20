import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../../../core/theme/splash_theme.dart';
import 'dashed_circle_painter.dart';
import 'filling_logo.dart';
import 'orbiting_dot.dart';

class LogoSection extends StatelessWidget {
  const LogoSection({
    super.key,
    required this.rotateController,
    required this.glowController,
    required this.glowAnimation,
    required this.pulseController,
    required this.logoController,
    required this.logoOpacity,
    required this.logoScale,
    required this.fillController,
    required this.orbitController,
    required this.shimmerController,
  });
  final Animation<double> orbitController;
  final AnimationController rotateController;
  final AnimationController glowController;
  final Animation<double> glowAnimation;
  final AnimationController pulseController;
  final AnimationController logoController;
  final Animation<double> logoOpacity;
  final Animation<double> logoScale;
  final AnimationController fillController;
  final AnimationController shimmerController;

  @override
  Widget build(BuildContext context) {
    final splashTheme = SplashTheme.of(context);

    return SizedBox(
      width: 280,
      height: 280,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Outer rotating dashed ring
          AnimatedBuilder(
            animation: rotateController,
            builder: (context, child) {
              return Transform.rotate(
                angle: rotateController.value * 2 * math.pi,
                child: CustomPaint(
                  size: const Size(260, 260),
                  painter: DashedCirclePainter(
                    color: splashTheme.ringColor(0.15),
                    strokeWidth: 1.5,
                    dashLength: 8,
                    gapLength: 6,
                  ),
                ),
              );
            },
          ),

          // Middle static ring with glow
          AnimatedBuilder(
            animation: glowController,
            builder: (context, child) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 100),
                width: 220,
                height: 220,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: splashTheme.ringColor(
                      0.1 + (glowAnimation.value * 0.1),
                    ),
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: splashTheme.ringColor(glowAnimation.value * 0.15),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
              );
            },
          ),

          // Inner pulsing ring
          AnimatedBuilder(
            animation: pulseController,
            builder: (context, child) {
              final scale = 1.0 + (pulseController.value * 0.02);
              return Transform.scale(
                scale: scale,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 100),
                  width: 190,
                  height: 190,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: splashTheme.ringColor(0.08),
                      width: 1,
                    ),
                  ),
                ),
              );
            },
          ),

          // Logo AnimatedContainer with glassmorphism
          AnimatedBuilder(
            animation: Listenable.merge([
              logoController,
              fillController,
              glowController,
            ]),
            builder: (context, child) {
              return Opacity(
                opacity: logoOpacity.value.clamp(0.0, 1.0),
                child: Transform.scale(
                  scale: logoScale.value.clamp(0.0, 1.0),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 100),
                    width: 160,
                    height: 160,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: splashTheme.logoBackgroundColor,
                      boxShadow: [
                        BoxShadow(
                          color: splashTheme.ringColor(
                            0.1 + (glowAnimation.value * 0.1),
                          ),
                          blurRadius: 50,
                          spreadRadius: 0,
                        ),
                        BoxShadow(
                          color: splashTheme.shadowColor,
                          blurRadius: 30,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                        child: FillingLogo(
                          fillController: fillController,
                          fillAnimation: fillController,
                          shimmerController: shimmerController,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),

          // Orbiting dots
          ...List.generate(
            3,
            (index) => OrbitingDot(animation: orbitController, index: index),
          ),
        ],
      ),
    );
  }
}
