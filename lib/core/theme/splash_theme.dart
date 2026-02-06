import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Theme helper for splash screen to support light/dark mode
class SplashTheme {
  final bool isDark;
  final Color backgroundColor;
  final Color primaryColor;
  final Color textColor;
  final Color subtitleColor;
  final Color logoBackgroundColor;
  final Color logoBaseColor;
  final Color shadowColor;
  final List<Color> backgroundGradient;

  const SplashTheme._({
    required this.isDark,
    required this.backgroundColor,
    required this.primaryColor,
    required this.textColor,
    required this.subtitleColor,
    required this.logoBackgroundColor,
    required this.logoBaseColor,
    required this.shadowColor,
    required this.backgroundGradient,
  });

  /// Light theme for splash screen
  static SplashTheme get light => SplashTheme._(
    isDark: false,
    backgroundColor: AppColors.whiteFF,
    primaryColor: AppColors.primerColor,
    textColor: AppColors.black,
    subtitleColor: AppColors.grayA6,
    logoBackgroundColor: AppColors.whiteFF,
    logoBaseColor: AppColors.grayCF,
    shadowColor: AppColors.black.withValues(alpha: 0.06),
    backgroundGradient: [
      AppColors.whiteFF,
      AppColors.whiteF9,
      AppColors.primerColor.withValues(alpha: 0.02),
      AppColors.primerColor.withValues(alpha: 0.05),
    ],
  );

  /// Dark theme for splash screen
  static SplashTheme get dark => SplashTheme._(
    isDark: true,
    backgroundColor: AppColors.black0C,
    primaryColor: AppColors.primerColor,
    textColor: AppColors.whiteFF,
    subtitleColor: AppColors.grayA6,
    logoBackgroundColor: AppColors.black35,
    logoBaseColor: AppColors.gray7D,
    shadowColor: AppColors.primerColor.withValues(alpha: 0.15),
    backgroundGradient: [
      AppColors.black0C,
      AppColors.black0A,
      AppColors.primerColor.withValues(alpha: 0.03),
      AppColors.primerColor.withValues(alpha: 0.08),
    ],
  );

  /// Get SplashTheme based on current context brightness
  static SplashTheme of(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark ? dark : light;
  }

  /// Ring color with opacity for glow effects
  Color ringColor(double opacity) =>
      primaryColor.withValues(alpha: isDark ? opacity * 1.5 : opacity);

  /// Particle color with opacity
  Color particleColor(double opacity) =>
      primaryColor.withValues(alpha: isDark ? opacity * 1.2 : opacity);

  /// Decorative circle gradient colors
  List<Color> get decorativeGradient => [
    primaryColor.withValues(alpha: isDark ? 0.12 : 0.08),
    primaryColor.withValues(alpha: isDark ? 0.04 : 0.02),
    Colors.transparent,
  ];

  /// Slogan container background
  Color get sloganBackground =>
      primaryColor.withValues(alpha: isDark ? 0.1 : 0.05);

  /// Slogan container border
  Color get sloganBorder => primaryColor.withValues(alpha: isDark ? 0.2 : 0.1);
}
