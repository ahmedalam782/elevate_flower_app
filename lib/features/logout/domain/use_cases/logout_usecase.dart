import '../../../../core/config/base_response/result.dart';
import '../../data/models/logout_response_model.dart';
import '../repositories/logout_repository.dart';
import 'package:injectable/injectable.dart';
@injectable
class LogoutUseCase {
  final LogoutRepository repository;

  LogoutUseCase(this.repository);

  Future<Result<LogoutResponseModel>> call() async {
    return await repository.logout();
  }
}