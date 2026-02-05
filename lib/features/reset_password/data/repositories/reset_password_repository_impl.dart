import '../../../../core/config/base_response/result.dart';
import '../datasources/reset_password_remote_data_source_contract.dart';
import '../../domain/entities/change_password_entity.dart';
import 'package:injectable/injectable.dart';
import '../../domain/repositories/reset_password_repository.dart';

@LazySingleton(as: ResetPasswordRepository)
class ResetPasswordRepositoryImpl implements ResetPasswordRepository {
  final ResetPasswordRemoteDataSource remoteDataSource;

  ResetPasswordRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Result<ChangePasswordEntity>> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      final model = await remoteDataSource.changePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
      );

      final entity = model.toEntity();

      return Success(data: entity);
    } catch (e) {
      return Error(exception: Exception(e.toString()));
    }
  }
}
