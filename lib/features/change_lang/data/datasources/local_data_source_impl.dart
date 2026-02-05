import 'package:easy_localization/easy_localization.dart';
import '../../../../core/config/api/end_points.dart';
import '../../../../core/config/base_response/result.dart';
import 'local_data_source.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@LazySingleton(as: ChangeLangLocalDataSource)
class ChangeLangLocalDataSourceImpl implements ChangeLangLocalDataSource {
  final SharedPreferences sharedPreferences;

  ChangeLangLocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<Result<String>> getLanguage() async {
    try {
      final language =
          sharedPreferences.getString(Apikeys.language) ??
          'en'; // Default to English

      return Success(data: language);
    } catch (e) {
      return Error(
        exception: Exception(
          'Failed to get language from shared preferences: $e',
        ),
      );
    }
  }

  @override
  Future<Result<void>> setLanguage(
    Locale language,
    BuildContext context,
  ) async {
    try {
      await context.setLocale(language);
      await sharedPreferences.setString(Apikeys.language, language.languageCode);
      return const Success();
    } catch (e) {
      return Error(
        exception: Exception(
          'Failed to set language in shared preferences: $e',
        ),
      );
    }
  }
}
