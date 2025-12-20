import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_images.dart';
import '../../../../../core/theme/splash_theme.dart';

class FillingLogo extends StatelessWidget {
  const FillingLogo({
    super.key,
    required this.fillController,
    required this.fillAnimation,
    required this.shimmerController,
  });

  final AnimationController fillController;
  final Animation<double> fillAnimation;
  final AnimationController shimmerController;

  @override
  Widget build(BuildContext context) {
    final splashTheme = SplashTheme.of(context);

    return AnimatedBuilder(
      animation: fillController,
      builder: (context, child) {
        return Container(
          width: 160,
          height: 160,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: splashTheme.logoBackgroundColor,
          ),
          child: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                width: 100,
                height: 100,
                color: AppColors.whiteFF,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Full colored logo
                    Image.asset(
                      AppImages.imagesIcLauncherIos,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                    // Shimmer overlay for animation effect
                    AnimatedBuilder(
                      animation: shimmerController,
                      builder: (context, child) {
                        return ShaderMask(
                          shaderCallback: (bounds) {
                            return LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.transparent,
                                Colors.white.withValues(alpha: 0.3),
                                Colors.transparent,
                              ],
                              stops: [
                                shimmerController.value - 0.3,
                                shimmerController.value,
                                shimmerController.value + 0.3,
                              ].map((e) => e.clamp(0.0, 1.0)).toList(),
                            ).createShader(bounds);
                          },
                          blendMode: BlendMode.srcATop,
                          child: Image.asset(
                            AppImages.imagesIcLauncherIos,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
