import '../entities/login_response_entity.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/config/base_response/result.dart';
import '../repositories/login_repository.dart';

@lazySingleton
class LoginUseCase {
  final LoginRepository repository;

  LoginUseCase({required this.repository});

  Future<Result<LoginResponseEntity>> call({
    required String email,
    required String password,
    required bool rememberMe,
  }) async {
    return await repository.loginUser(
      email: email,
      password: password,
      rememberMe: rememberMe,
    );
  }
}
