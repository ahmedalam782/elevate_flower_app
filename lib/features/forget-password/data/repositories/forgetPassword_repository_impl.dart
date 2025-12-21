// TODO: data ForgetPasswordRepositoryImpl

import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/forget-password/data/datasources/forgetPassword_remote_data_source_contract.dart';
import 'package:elevate_flower_app/features/forget-password/data/models/forget_password_response/forget_password_response.dart';
import 'package:elevate_flower_app/features/forget-password/domain/entities/forget_password_entity/forget_password_entity.dart';
import 'package:elevate_flower_app/features/forget-password/domain/repositories/forgetPassword_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ForgetpasswordRepository)
class ForgetpasswordRepositoryImpl implements ForgetpasswordRepository {
  final ForgetpasswordRemoteDataSourceContract remoteDataSource;

  ForgetpasswordRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Result<ForgetPasswordEntity>> sendOtpToEmail(String email) async {
    final response = await remoteDataSource.sendOtpToEmail(email);
    switch (response) {
      case Success<ForgetPasswordResponse>():
        return Success<ForgetPasswordEntity>(
          data: response.data?.toForgetPasswordEntity(),
        );
      case Error<ForgetPasswordResponse>():
        return Error<ForgetPasswordEntity>(exception: response.exception);
    }
  }
}
