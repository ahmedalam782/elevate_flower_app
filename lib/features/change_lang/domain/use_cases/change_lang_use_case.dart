import '../../../../core/config/base_response/result.dart';
import '../repositories/change_lang_repo.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ChangeLangUseCase {
  final ChangeLangRepo changeLangRepo;

  ChangeLangUseCase(this.changeLangRepo);
  Future<Result<void>> call({
    required Locale locale,
    required BuildContext context,
  }) async {
    return await changeLangRepo.changeLanguage(locale, context);
  }
}
