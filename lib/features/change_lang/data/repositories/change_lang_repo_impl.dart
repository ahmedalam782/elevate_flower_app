import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/change_lang/data/datasources/local_data_source.dart';
import 'package:elevate_flower_app/features/change_lang/domain/repositories/change_lang_repo.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ChangeLangRepo)
class ChangeLangRepoImpl implements ChangeLangRepo {
  final ChangeLangLocalDataSource localDataSource;

  ChangeLangRepoImpl(this.localDataSource);

  @override
  Future<Result<void>> changeLanguage(Locale locale, BuildContext context) async {
    final result = await localDataSource.setLanguage(locale, context);
    return result.when(
      success: (data) => const Success(),
      error: (exception) => Error(exception: exception),
    );
  }

  @override
  Future<Result<String>> getCurrentLanguage() async {
    final result = await localDataSource.getLanguage();
    return result.when(
      success: (data) => Success(data: data),
      error: (exception) => Error(exception: exception),
    );
  }
}
