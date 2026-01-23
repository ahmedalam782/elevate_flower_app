import 'package:elevate_flower_app/core/config/base_state/base_state.dart';
import 'package:elevate_flower_app/features/forget_password/presentation/view_model/cubit/forget_password_cubit.dart';
import 'package:elevate_flower_app/features/forget_password/presentation/view_model/cubit/forget_password_events.dart';
import 'package:elevate_flower_app/features/forget_password/domain/entities/forget_password_entity/forget_password_entity.dart';
import 'package:elevate_flower_app/features/forget_password/domain/use_cases/send_otp_to_email_use_case.dart';
import 'package:elevate_flower_app/features/forget_password/domain/use_cases/verify_otp_use_case.dart';
import 'package:elevate_flower_app/features/forget_password/domain/use_cases/reset_password_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:elevate_flower_app/core/config/base_response/result.dart';

import 'forget_password_cubit_test.mocks.dart';

@GenerateMocks([SendOtpToEmailUseCase, VerifyOtpUseCase, ResetPasswordUseCase])
void main() {
  late ForgetPasswordCubit cubit;
  late MockSendOtpToEmailUseCase mockSendOtpToEmailUseCase;
  late MockVerifyOtpUseCase mockVerifyOtpUseCase;
  late MockResetPasswordUseCase mockResetPasswordUseCase;

  setUpAll(() {
    provideDummy<Result<ForgetPasswordEntity>>(
      const Success<ForgetPasswordEntity>(data: null),
    );
    provideDummy<Result<void>>(const Success<void>(data: null));
  });

  setUp(() {
    mockSendOtpToEmailUseCase = MockSendOtpToEmailUseCase();
    mockVerifyOtpUseCase = MockVerifyOtpUseCase();
    mockResetPasswordUseCase = MockResetPasswordUseCase();
    cubit = ForgetPasswordCubit(
      sendOtpToEmailUseCase: mockSendOtpToEmailUseCase,
      verifyOtpUseCase: mockVerifyOtpUseCase,
      resetPasswordUseCase: mockResetPasswordUseCase,
    );
    // Disable loading overlay and page animation for testing
    cubit.showLoading = false;
    cubit.animatePage = false;
  });

  tearDown(() {
    cubit.close();
  });

  group('ForgetPasswordCubit Tests', () {
    test('initial state is correct', () {
      expect(cubit.state.isLoading, false);
      expect(cubit.state.state, StateType.initial);
      expect(cubit.state.currentScreen, 0);
      expect(cubit.state.isPasswordReset, false);
    });

    group('SendOtpToEmailEvent', () {
      test(
        'emits loading then success when OTP is sent successfully',
        () async {
          // Arrange
          final testEntity = ForgetPasswordEntity(
            message: 'OTP sent successfully',
            info: 'success',
          );

          when(mockSendOtpToEmailUseCase.call(any)).thenAnswer(
            (_) async => Success<ForgetPasswordEntity>(data: testEntity),
          );

          cubit.emailController.text = 'test@email.com';

          // Act & Assert
          final states = cubit.stream.take(2).toList();

          cubit.doIntent(SendOtpToEmailEvent(), null);

          final result = await states;

          expect(result[0].state, StateType.loading);
          expect(result[1].state, StateType.success);
          expect(result[1].forgetPasswordEntity, testEntity);
          expect(result[1].currentScreen, 1);

          verify(mockSendOtpToEmailUseCase.call('test@email.com')).called(1);
        },
      );

      test('emits loading then error when OTP sending fails', () async {
        // Arrange
        final exception = Exception('Network error');

        when(mockSendOtpToEmailUseCase.call(any)).thenAnswer(
          (_) async => Error<ForgetPasswordEntity>(exception: exception),
        );

        cubit.emailController.text = 'test@email.com';

        // Act & Assert
        final states = cubit.stream.take(2).toList();

        cubit.doIntent(SendOtpToEmailEvent(), null);

        final result = await states;

        expect(result[0].state, StateType.loading);
        expect(result[1].state, StateType.error);
        expect(result[1].exception, exception);

        verify(mockSendOtpToEmailUseCase.call('test@email.com')).called(1);
      });
    });

    group('VerifyOtpEvent', () {
      test(
        'emits loading then success when OTP is verified successfully',
        () async {
          // Arrange
          when(
            mockVerifyOtpUseCase.call(any),
          ).thenAnswer((_) async => const Success<void>(data: null));

          // Act & Assert
          final states = cubit.stream.take(2).toList();

          cubit.doIntent(VerifyOtpEvent(otp: '123456'), null);

          final result = await states;

          expect(result[0].state, StateType.loading);
          expect(result[1].state, StateType.success);
          expect(result[1].currentScreen, 2);

          verify(mockVerifyOtpUseCase.call('123456')).called(1);
        },
      );

      test('emits loading then error when OTP verification fails', () async {
        // Arrange
        final exception = Exception('Invalid OTP');

        when(
          mockVerifyOtpUseCase.call(any),
        ).thenAnswer((_) async => Error<void>(exception: exception));

        // Act & Assert
        final states = cubit.stream.take(2).toList();

        cubit.doIntent(VerifyOtpEvent(otp: '000000'), null);

        final result = await states;

        expect(result[0].state, StateType.loading);
        expect(result[1].state, StateType.error);
        expect(result[1].exception, exception);

        verify(mockVerifyOtpUseCase.call('000000')).called(1);
      });
    });

    group('ResetPasswordEvent', () {
      test(
        'emits loading then success when password is reset successfully',
        () async {
          // Arrange
          when(
            mockResetPasswordUseCase.call(any),
          ).thenAnswer((_) async => const Success<void>(data: null));

          cubit.emailController.text = 'test@email.com';
          cubit.passwordController.text = 'newPassword123';

          // Act & Assert
          final states = cubit.stream.take(2).toList();

          cubit.doIntent(ResetPasswordEvent(), null);

          final result = await states;

          expect(result[0].state, StateType.loading);
          expect(result[1].state, StateType.success);
          expect(result[1].isPasswordReset, true);

          verify(mockResetPasswordUseCase.call(any)).called(1);
        },
      );

      test('emits loading then error when password reset fails', () async {
        // Arrange
        final exception = Exception('Password reset failed');

        when(
          mockResetPasswordUseCase.call(any),
        ).thenAnswer((_) async => Error<void>(exception: exception));

        cubit.emailController.text = 'test@email.com';
        cubit.passwordController.text = 'newPassword123';

        // Act & Assert
        final states = cubit.stream.take(2).toList();

        cubit.doIntent(ResetPasswordEvent(), null);

        final result = await states;

        expect(result[0].state, StateType.loading);
        expect(result[1].state, StateType.error);
        expect(result[1].exception, exception);

        verify(mockResetPasswordUseCase.call(any)).called(1);
      });
    });

    group('TogglePasswordEvent', () {
      test('toggles new password visibility', () async {
        // Arrange
        final initialVisibility = cubit.state.newPasswordVisible;

        // Act
        await cubit.doIntent(
          TogglePasswordEvent(isConfirmPassword: false),
          null,
        );

        // Assert
        expect(cubit.state.newPasswordVisible, !initialVisibility);
      });

      test('toggles confirm password visibility', () async {
        // Arrange
        final initialVisibility = cubit.state.confirmPasswordVisible;

        // Act
        await cubit.doIntent(
          TogglePasswordEvent(isConfirmPassword: true),
          null,
        );

        // Assert
        expect(cubit.state.confirmPasswordVisible, !initialVisibility);
      });
    });

    test('controllers are properly initialized', () {
      expect(cubit.emailController, isNotNull);
      expect(cubit.passwordController, isNotNull);
      expect(cubit.confirmPasswordController, isNotNull);
      expect(cubit.pageController, isNotNull);
    });

    test('controllers are disposed on close', () async {
      // Create a separate cubit instance for this test
      final separateCubit = ForgetPasswordCubit(
        sendOtpToEmailUseCase: mockSendOtpToEmailUseCase,
        verifyOtpUseCase: mockVerifyOtpUseCase,
        resetPasswordUseCase: mockResetPasswordUseCase,
      );

      await separateCubit.close();

      expect(
        () => separateCubit.emailController.text = 'test',
        throwsA(isA<AssertionError>()),
      );
    });
  });
}
