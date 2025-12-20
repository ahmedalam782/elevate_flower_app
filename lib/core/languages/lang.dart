import 'package:flutter/material.dart';

enum LanguageType { arabic, english }

const String arabic = 'ar';
const String english = 'en';

const String assetsLocalization = 'assets/localization';

const Locale arabicLocale = Locale("ar", "EG");
const Locale englishLocale = Locale("en", "US");

extension LanguageTypeExtension on LanguageType {
  String getValue() {
    switch (this) {
      case LanguageType.arabic:
        return arabic;
      case LanguageType.english:
        return english;
    }
  }
}

class LanguageHelper {
  static const String arabicFontFamily = 'RobotoArabic';
  static const String englishFontFamily = 'RobotoEnglish';
}

// Generate Locale Keys
// flutter pub run easy_localization:generate -S assets/localization -O lib/core/languages -f keys -o locale_keys.g.dart
