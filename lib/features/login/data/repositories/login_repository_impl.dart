import 'package:injectable/injectable.dart';

import '../../../../core/config/api/api_executer.dart';
import '../../../../core/config/base_response/result.dart';
import '../../domain/repositories/login_repository.dart';
import '../datasources/login_local_data_source_contract.dart';
import '../datasources/login_remote_data_source_contract.dart';
import '../models/login_request_model.dart';
import '../models/login_response_model.dart';

@LazySingleton(as: LoginRepository)
class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDataSourceContract remoteDataSource;
  final LoginLocalDataSourceContract localDataSource;

  LoginRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Result<LoginResponseModel>> loginUser({
    required String email,
    required String password,
    required bool rememberMe,
  }) async {
    // استخدام executeApi للتحقق من الانترنت
    return executeApi<LoginResponseModel>(() async {
      // 1. إنشاء الـ request
      final request = LoginRequestModel(
        email: email,
        password: password,
      );

      // 2. استدعاء الـ remote data source
      final result = await remoteDataSource.loginUser(
        body: request,
        rememberMe: rememberMe,
      );

      // 3. معالجة النتيجة
      return await result.when(
        success: (responseModel) async {
          if (responseModel != null) {
            // حفظ البيانات محلياً
            await localDataSource.saveToken(responseModel.token);
            await localDataSource.saveUserId(responseModel.user.id);
            await localDataSource.saveRememberMe(rememberMe);

            // إرجاع الـ Model مباشرة (مش Entity)
            return responseModel;
          }
          throw Exception('Response is null');
        },
        error: (exception) {
          // في حالة الخطأ، نرمي الـ exception عشان executeApi تمسكها
          throw exception!;
        },
      );
    });
  }
}