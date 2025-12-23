import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/forget-password/data/datasources/forgetPassword_remote_data_source_contract.dart';
import 'package:elevate_flower_app/features/forget-password/data/models/forget_password_response/forget_password_response.dart';
import 'package:elevate_flower_app/features/forget-password/data/models/reset_password_dto/reset_password_dto.dart';
import 'package:elevate_flower_app/features/forget-password/data/repositories/forgetPassword_repository_impl.dart';
import 'package:elevate_flower_app/features/forget-password/domain/entities/forget_password_entity/forget_password_entity.dart';

import 'forgetpassword_repository_impl_test.mocks.dart';

@GenerateMocks([ForgetpasswordRemoteDataSourceContract])
void main() {
  late ForgetpasswordRepositoryImpl repository;
  late MockForgetpasswordRemoteDataSourceContract mockRemoteDataSource;

  /// ---------------------------------------------------------
  /// Mockito dummy values (REQUIRED for sealed + generic Result)
  /// ---------------------------------------------------------
  setUpAll(() {
    provideDummy<Result<ForgetPasswordResponse>>(
      const Success<ForgetPasswordResponse>(),
    );

    provideDummy<Result<void>>(const Success<void>());
  });

  setUp(() {
    mockRemoteDataSource = MockForgetpasswordRemoteDataSourceContract();
    repository = ForgetpasswordRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
    );
  });

  // =========================================================
  // sendOtpToEmail
  // =========================================================
  group('sendOtpToEmail', () {
    const email = 'test@email.com';

    test('returns Success<ForgetPasswordEntity> '
        'when remote returns Success<ForgetPasswordResponse>', () async {
      // Arrange
      final dto = ForgetPasswordResponse(info: 'success', message: 'OTP sent');

      when(
        mockRemoteDataSource.sendOtpToEmail(email),
      ).thenAnswer((_) async => Success<ForgetPasswordResponse>(data: dto));

      // Act
      final result = await repository.sendOtpToEmail(email);

      // Assert
      expect(result, isA<Success<ForgetPasswordEntity>>());

      final success = result as Success<ForgetPasswordEntity>;
      expect(success.data, isNotNull);
      expect(success.data!.info, dto.info);
      expect(success.data!.message, dto.message);

      verify(mockRemoteDataSource.sendOtpToEmail(email)).called(1);

      verifyNoMoreInteractions(mockRemoteDataSource);
    });

    test('returns Error<ForgetPasswordEntity> '
        'when remote returns Error<ForgetPasswordResponse>', () async {
      // Arrange
      final exception = Exception('Invalid email');

      when(mockRemoteDataSource.sendOtpToEmail(email)).thenAnswer(
        (_) async => Error<ForgetPasswordResponse>(exception: exception),
      );

      // Act
      final result = await repository.sendOtpToEmail(email);

      // Assert
      expect(result, isA<Error<ForgetPasswordEntity>>());

      final error = result as Error<ForgetPasswordEntity>;
      expect(error.exception, exception);

      verify(mockRemoteDataSource.sendOtpToEmail(email)).called(1);
    });
  });

  // =========================================================
  // verifyCode
  // =========================================================
  group('verifyCode', () {
    const code = '123456';

    test('returns Success<void> when remote returns Success<void>', () async {
      // Arrange
      when(
        mockRemoteDataSource.verifyCode(code),
      ).thenAnswer((_) async => const Success<void>());

      // Act
      final result = await repository.verifyCode(code);

      // Assert
      expect(result, isA<Success<void>>());

      verify(mockRemoteDataSource.verifyCode(code)).called(1);

      verifyNoMoreInteractions(mockRemoteDataSource);
    });

    test('returns Error<void> when remote returns Error<void>', () async {
      // Arrange
      final exception = Exception('Invalid code');

      when(
        mockRemoteDataSource.verifyCode(code),
      ).thenAnswer((_) async => Error<void>(exception: exception));

      // Act
      final result = await repository.verifyCode(code);

      // Assert
      expect(result, isA<Error<void>>());

      final error = result as Error<void>;
      expect(error.exception, exception);

      verify(mockRemoteDataSource.verifyCode(code)).called(1);
    });
  });

  // =========================================================
  // resetPassword
  // =========================================================
  group('resetPassword', () {
    final dto = ResetPasswordDTo(
      email: 'test@email.com',
      newPassword: 'Aa@12345',
    );

    test('returns Success<void> when remote returns Success<void>', () async {
      // Arrange
      when(
        mockRemoteDataSource.resetPassword(dto),
      ).thenAnswer((_) async => const Success<void>());

      // Act
      final result = await repository.resetPassword(dto);

      // Assert
      expect(result, isA<Success<void>>());

      verify(mockRemoteDataSource.resetPassword(dto)).called(1);

      verifyNoMoreInteractions(mockRemoteDataSource);
    });

    test('returns Error<void> when remote returns Error<void>', () async {
      // Arrange
      final exception = Exception('Weak password');

      when(
        mockRemoteDataSource.resetPassword(dto),
      ).thenAnswer((_) async => Error<void>(exception: exception));

      // Act
      final result = await repository.resetPassword(dto);

      // Assert
      expect(result, isA<Error<void>>());

      final error = result as Error<void>;
      expect(error.exception, exception);

      verify(mockRemoteDataSource.resetPassword(dto)).called(1);
    });
  });
}
