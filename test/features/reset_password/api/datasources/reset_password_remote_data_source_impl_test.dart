import 'package:elevate_flower_app/features/reset_password/api/api_client/reset_password_api_client.dart';
import 'package:elevate_flower_app/features/reset_password/api/datasources/reset_password_remote_data_source_impl.dart';
import 'package:elevate_flower_app/features/reset_password/data/models/change_password_response_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'reset_password_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([ResetPasswordApiClient])
void main() {
  late ResetPasswordRemoteDataSourceImpl remoteDataSource;
  late MockResetPasswordApiClient mockApiClient;

  setUp(() {
    mockApiClient = MockResetPasswordApiClient();
    remoteDataSource = ResetPasswordRemoteDataSourceImpl(mockApiClient);
  });

  group('ResetPasswordRemoteDataSourceImpl', () {
    const tCurrentPassword = 'password123';
    const tNewPassword = 'newPassword123';
    final tResponseModel = ChangePasswordResponseModel(
      message: 'Password changed successfully',
      token: 'some_token',
    );

    test(
      'should return ChangePasswordResponseModel when the call is successful',
      () async {
        // Arrange
        when(
          mockApiClient.changePassword(any),
        ).thenAnswer((_) async => tResponseModel);

        // Act
        final result = await remoteDataSource.changePassword(
          currentPassword: tCurrentPassword,
          newPassword: tNewPassword,
        );

        // Assert
        expect(result, tResponseModel);
        verify(mockApiClient.changePassword(any));
        verifyNoMoreInteractions(mockApiClient);
      },
    );

    test('should throw an exception when the call fails', () async {
      // Arrange
      when(mockApiClient.changePassword(any)).thenThrow(Exception('Error'));

      // Act
      final call = remoteDataSource.changePassword;

      // Assert
      expect(
        () =>
            call(currentPassword: tCurrentPassword, newPassword: tNewPassword),
        throwsException,
      );
      verify(mockApiClient.changePassword(any));
      verifyNoMoreInteractions(mockApiClient);
    });
  });
}
