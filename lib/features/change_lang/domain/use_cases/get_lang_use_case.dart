import '../../../../core/config/base_response/result.dart';
import '../repositories/change_lang_repo.dart';
import 'package:injectable/injectable.dart';
@lazySingleton
class GetLangUseCase {
  final ChangeLangRepo changeLangRepo;

  GetLangUseCase(this.changeLangRepo);

  Future<Result<String>> call() async {
    return await changeLangRepo.getCurrentLanguage();
  }
}
