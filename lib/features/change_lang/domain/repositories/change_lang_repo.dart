import '../../../../core/config/base_response/result.dart';
import 'package:flutter/material.dart';

abstract class ChangeLangRepo {
  Future<Result<void>> changeLanguage(Locale locale, BuildContext context);
  Future<Result<String>> getCurrentLanguage();
}