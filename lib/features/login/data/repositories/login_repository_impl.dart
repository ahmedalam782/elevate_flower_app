import 'package:elevate_flower_app/features/login/data/models/login_model_mapper.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/config/base_response/result.dart';
import '../../domain/entities/login_response_entity.dart';
import '../../domain/repositories/login_repository.dart';
import '../datasources/login_local_data_source_contract.dart';
import '../datasources/login_remote_data_source_contract.dart';
import '../models/login_request_model.dart';

@LazySingleton(as: LoginRepository)
class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDataSourceContract _remoteDataSource;
  final LoginLocalDataSourceContract _localDataSource;

  LoginRepositoryImpl(this._remoteDataSource, this._localDataSource);

  @override
  Future<Result<LoginResponseEntity>> loginUser({
    required String email,
    required String password,
    required bool rememberMe,
  }) async {
    // 1. إنشاء الـ request
    final request = LoginRequestModel(email: email, password: password);

    // 2. استدعاء الـ remote data source
    final result = await _remoteDataSource.loginUser(
      body: request,
      rememberMe: rememberMe,
    );

    // 3. معالجة النتيجة وتحويلها من Model إلى Entity
    return result.when(
      success: (data) async {
        if (data != null) {
          // حفظ البيانات محلياً
          await _localDataSource.saveToken(data.token);
          await _localDataSource.saveRememberMe(rememberMe);

          // تحويل الـ Model إلى Entity باستخدام الـ Mapper
          final entity = data.toEntity();

          // إرجاع الـ Entity
          return Success<LoginResponseEntity>(data: entity);
        } else {
          return Error<LoginResponseEntity>(
            exception: Exception('Response is null'),
          );
        }
      },
      error: (exception) {
        return Error<LoginResponseEntity>(exception: exception);
      },
    );
  }
}
