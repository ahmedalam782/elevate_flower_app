import 'package:flutter/material.dart';

import '../languages/lang.dart';
import 'app_colors.dart';

class AppTypography {
  AppTypography._();

  static String _locale = arabic;
  static Brightness _brightness = Brightness.dark;

  static const Map<String, String> _fontFamilies = {
    arabic: LanguageHelper.arabicFontFamily,

    english: LanguageHelper.englishFontFamily,
  };

  static const Map<Brightness, Color> _textColors = {
    Brightness.dark: AppColors.whiteF9,
    Brightness.light: AppColors.black0C,
  };

  static void setLocale(String locale) => _locale = locale;

  static void setTheme(Brightness brightness) => _brightness = brightness;

  static String get locale => _locale;

  static Brightness get brightness => _brightness;

  static String get fontFamily =>
      _fontFamilies[_locale] ?? _fontFamilies[arabic]!;

  static Color get textColor => _textColors[_brightness]!;
}

extension TextStyleExtension on num {
  TextStyle get bold => TextStyle(
    fontSize: toDouble(),
    fontWeight: FontWeight.w700,
    fontFamily: AppTypography.fontFamily,
    color: AppTypography.textColor,
  );

  TextStyle get semiBold => TextStyle(
    fontSize: toDouble(),
    fontWeight: FontWeight.w600,
    fontFamily: AppTypography.fontFamily,
    color: AppTypography.textColor,
  );

  TextStyle get medium => TextStyle(
    fontSize: toDouble(),
    fontWeight: FontWeight.w500,
    fontFamily: AppTypography.fontFamily,
    color: AppTypography.textColor,
  );

  TextStyle get regular => TextStyle(
    fontSize: toDouble(),
    fontWeight: FontWeight.w400,
    fontFamily: AppTypography.fontFamily,
    color: AppTypography.textColor,
  );

  TextStyle get light => TextStyle(
    fontSize: toDouble(),
    fontWeight: FontWeight.w300,
    fontFamily: AppTypography.fontFamily,
    color: AppTypography.textColor,
  );

  TextStyle get extraLight => TextStyle(
    fontSize: toDouble(),
    fontWeight: FontWeight.w200,
    fontFamily: AppTypography.fontFamily,
    color: AppTypography.textColor,
  );
}
