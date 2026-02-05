
import '../../../../core/config/base_response/result.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/forget_password_entity/forget_password_entity.dart';
import '../../domain/repositories/forget_Password_repository.dart';
import '../datasources/forget_Password_remote_data_source_contract.dart';
import '../models/forget_password_response/forget_password_response.dart';
import '../models/reset_password_dto/reset_password_dto.dart';

@Injectable(as: ForgetPasswordRepository)
class ForgetPasswordRepositoryImpl implements ForgetPasswordRepository {
  final ForgetPasswordRemoteDataSourceContract remoteDataSource;

  ForgetPasswordRepositoryImpl({required this.remoteDataSource});

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

  @override
  Future<Result<void>> verifyCode(String code) async {
    final response = await remoteDataSource.verifyCode(code);
    switch (response) {
      case Success<void>():
        return const Success<void>();
      case Error<void>():
        return Error<void>(exception: response.exception);
    }
  }

  @override
  Future<Result<void>> resetPassword(ResetPasswordDTo data) async {
    final response = await remoteDataSource.resetPassword(data);
    switch (response) {
      case Success<void>():
        return const Success<void>();
      case Error<void>():
        return Error<void>(exception: response.exception);
    }
  }
}
