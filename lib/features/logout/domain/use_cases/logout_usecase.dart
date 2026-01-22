import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/logout/data/models/logout_response_model.dart';
import 'package:elevate_flower_app/features/logout/domain/repositories/logout_repository.dart';

class LogoutUseCase {
  final LogoutRepository repository;

  LogoutUseCase(this.repository);

  Future<Result<LogoutResponseModel>> call() async {
    return await repository.logout();
  }
}