import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/reset_password/data/datasources/reset_password_remote_data_source_contract.dart';
import 'package:elevate_flower_app/features/reset_password/data/models/change_password_response_model.dart';
import 'package:elevate_flower_app/features/reset_password/data/repositories/reset_password_repository_impl.dart';
import 'package:elevate_flower_app/features/reset_password/domain/entities/change_password_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'reset_password_repository_impl_test.mocks.dart';

@GenerateMocks([ResetPasswordRemoteDataSource])
void main() {
  late ResetPasswordRepositoryImpl repository;
  late MockResetPasswordRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockResetPasswordRemoteDataSource();
    repository = ResetPasswordRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
    );
  });

  group('ResetPasswordRepositoryImpl', () {
    const tCurrentPassword = 'password123';
    const tNewPassword = 'newPassword123';
    final tResponseModel = ChangePasswordResponseModel(
      message: 'Password changed successfully',
      token: 'some_token',
    );
    final tEntity = ChangePasswordEntity(
      message: 'Password changed successfully',
      token: 'some_token',
    );

    test(
      'should return Success with ChangePasswordEntity when call to remote data source is successful',
      () async {
        // Arrange
        when(
          mockRemoteDataSource.changePassword(
            currentPassword: tCurrentPassword,
            newPassword: tNewPassword,
          ),
        ).thenAnswer((_) async => tResponseModel);

        // Act
        final result = await repository.changePassword(
          currentPassword: tCurrentPassword,
          newPassword: tNewPassword,
        );

        // Assert
        expect(result, isA<Success<ChangePasswordEntity>>());
        final successResult = result as Success<ChangePasswordEntity>;
        expect(successResult.data?.message, tEntity.message);
        expect(successResult.data?.token, tEntity.token);
        verify(
          mockRemoteDataSource.changePassword(
            currentPassword: tCurrentPassword,
            newPassword: tNewPassword,
          ),
        );
        verifyNoMoreInteractions(mockRemoteDataSource);
      },
    );

    test('should return Error when call to remote data source fails', () async {
      // Arrange
      when(
        mockRemoteDataSource.changePassword(
          currentPassword: tCurrentPassword,
          newPassword: tNewPassword,
        ),
      ).thenThrow(Exception('Failed to change password'));

      // Act
      final result = await repository.changePassword(
        currentPassword: tCurrentPassword,
        newPassword: tNewPassword,
      );

      // Assert
      expect(result, isA<Error<ChangePasswordEntity>>());
      verify(
        mockRemoteDataSource.changePassword(
          currentPassword: tCurrentPassword,
          newPassword: tNewPassword,
        ),
      );
      verifyNoMoreInteractions(mockRemoteDataSource);
    });
  });
}
