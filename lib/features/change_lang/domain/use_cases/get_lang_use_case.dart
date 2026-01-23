import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/change_lang/domain/repositories/change_lang_repo.dart';
import 'package:injectable/injectable.dart';
@lazySingleton
class GetLangUseCase {
  final ChangeLangRepo changeLangRepo;

  GetLangUseCase(this.changeLangRepo);

  Future<Result<String>> call() async {
    return await changeLangRepo.getCurrentLanguage();
  }
}
