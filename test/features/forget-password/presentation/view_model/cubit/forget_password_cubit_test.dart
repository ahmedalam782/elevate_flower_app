import 'package:bloc_test/bloc_test.dart';
import 'package:elevate_flower_app/core/config/base_state/base_state.dart';
import 'package:elevate_flower_app/features/forget_password/presentation/view_model/cubit/forget_password_cubit.dart';
import 'package:elevate_flower_app/features/forget_password/presentation/view_model/cubit/forget_password_states.dart';
import 'package:elevate_flower_app/features/forget_password/presentation/view_model/cubit/forget_password_events.dart';
import 'package:elevate_flower_app/features/forget_password/domain/entities/forget_password_entity/forget_password_entity.dart';
import 'package:elevate_flower_app/features/forget_password/domain/use_cases/send_otp_to_email_use_case.dart';
import 'package:elevate_flower_app/features/forget_password/domain/use_cases/verify_otp_use_case.dart';
import 'package:elevate_flower_app/features/forget_password/domain/use_cases/reset_password_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter/material.dart';
import 'package:elevate_flower_app/core/config/base_response/result.dart';

import 'forget_password_cubit_test.mocks.dart';

@GenerateMocks([SendOtpToEmailUseCase, VerifyOtpUseCase, ResetPasswordUseCase])
void main() {
  late ForgetPasswordCubit cubit;
  late MockSendOtpToEmailUseCase mockSendOtpToEmailUseCase;
  late MockVerifyOtpUseCase mockVerifyOtpUseCase;
  late MockResetPasswordUseCase mockResetPasswordUseCase;
  BuildContext? context;

  setUpAll(() {
    provideDummy<Result<ForgetPasswordEntity>>(
      const Success<ForgetPasswordEntity>(),
    );
    provideDummy<Result<void>>(const Success<void>());
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
    cubit.animatePage = false; // Disable animation for tests
    context = null;
  });

  group('SendOtpToEmailEvent', () {
    blocTest<ForgetPasswordCubit, ForgetPasswordStates>(
      'emits [loading, success] when doIntent(SendOtpToEmailEvent) succeeds',
      build: () {
        when(mockSendOtpToEmailUseCase.call(any)).thenAnswer(
          (_) async => Success<ForgetPasswordEntity>(
            data: ForgetPasswordEntity(message: 'OTP sent', info: 'success'),
          ),
        );
        return cubit;
      },
      act: (cubit) {
        cubit.emailController.text = 'test@email.com';
        return cubit.doIntent(SendOtpToEmailEvent(), context);
      },
      expect: () => [
        isA<ForgetPasswordStates>().having(
          (s) => s.state,
          'state',
          StateType.loading,
        ),
        isA<ForgetPasswordStates>()
            .having((s) => s.state, 'state', StateType.success)
            .having((s) => s.currentScreen, 'currentScreen', 1),
      ],
    );

    blocTest<ForgetPasswordCubit, ForgetPasswordStates>(
      'emits [loading, error] when doIntent(SendOtpToEmailEvent) fails',
      build: () {
        when(mockSendOtpToEmailUseCase.call(any)).thenAnswer(
          (_) async => Error<ForgetPasswordEntity>(
            exception: Exception('Failed to send OTP'),
          ),
        );
        return cubit;
      },
      act: (cubit) {
        cubit.emailController.text = 'test@email.com';
        return cubit.doIntent(SendOtpToEmailEvent(), context);
      },
      expect: () => [
        isA<ForgetPasswordStates>().having(
          (s) => s.state,
          'state',
          StateType.loading,
        ),
        isA<ForgetPasswordStates>().having(
          (s) => s.state,
          'state',
          StateType.error,
        ),
      ],
    );
  });

  group('VerifyOtpEvent', () {
    blocTest<ForgetPasswordCubit, ForgetPasswordStates>(
      'emits [loading, success] when doIntent(VerifyOtpEvent) succeeds',
      build: () {
        when(
          mockVerifyOtpUseCase.call(any),
        ).thenAnswer((_) async => const Success<void>());
        return cubit;
      },
      act: (cubit) => cubit.doIntent(VerifyOtpEvent(otp: '123456'), context),
      expect: () => [
        isA<ForgetPasswordStates>().having(
          (s) => s.state,
          'state',
          StateType.loading,
        ),
        isA<ForgetPasswordStates>()
            .having((s) => s.state, 'state', StateType.success)
            .having((s) => s.currentScreen, 'currentScreen', 2),
      ],
    );

    blocTest<ForgetPasswordCubit, ForgetPasswordStates>(
      'emits [loading, error] when doIntent(VerifyOtpEvent) fails',
      build: () {
        when(mockVerifyOtpUseCase.call(any)).thenAnswer(
          (_) async => Error<void>(exception: Exception('Invalid OTP')),
        );
        return cubit;
      },
      act: (cubit) => cubit.doIntent(VerifyOtpEvent(otp: '123456'), context),
      expect: () => [
        isA<ForgetPasswordStates>().having(
          (s) => s.state,
          'state',
          StateType.loading,
        ),
        isA<ForgetPasswordStates>().having(
          (s) => s.state,
          'state',
          StateType.error,
        ),
      ],
    );
  });

  group('ResetPasswordEvent', () {
    blocTest<ForgetPasswordCubit, ForgetPasswordStates>(
      'emits [loading, success] when doIntent(ResetPasswordEvent) succeeds',
      build: () {
        when(
          mockResetPasswordUseCase.call(any),
        ).thenAnswer((_) async => const Success<void>());
        return cubit;
      },
      act: (cubit) {
        cubit.emailController.text = 'test@email.com';
        cubit.passwordController.text = 'newpassword';
        return cubit.doIntent(ResetPasswordEvent(), context);
      },
      expect: () => [
        isA<ForgetPasswordStates>().having(
          (s) => s.state,
          'state',
          StateType.loading,
        ),
        isA<ForgetPasswordStates>()
            .having((s) => s.state, 'state', StateType.success)
            .having((s) => s.isPasswordReset, 'isPasswordReset', true),
      ],
    );

    blocTest<ForgetPasswordCubit, ForgetPasswordStates>(
      'emits [loading, error] when doIntent(ResetPasswordEvent) fails',
      build: () {
        when(mockResetPasswordUseCase.call(any)).thenAnswer(
          (_) async =>
              Error<void>(exception: Exception('Failed to reset password')),
        );
        return cubit;
      },
      act: (cubit) {
        cubit.emailController.text = 'test@email.com';
        cubit.passwordController.text = 'newpassword';
        return cubit.doIntent(ResetPasswordEvent(), context);
      },
      expect: () => [
        isA<ForgetPasswordStates>().having(
          (s) => s.state,
          'state',
          StateType.loading,
        ),
        isA<ForgetPasswordStates>().having(
          (s) => s.state,
          'state',
          StateType.error,
        ),
      ],
    );
  });

  group('TogglePasswordEvent', () {
    tearDown(() {
      cubit.close();
    });

    test('toggles newPasswordVisible when isConfirmPassword is false', () {
      final initialState = cubit.state;
      expect(initialState.newPasswordVisible, false);

      cubit.doIntent(TogglePasswordEvent(isConfirmPassword: false), context);

      expect(cubit.state.newPasswordVisible, true);
    });

    test('toggles confirmPasswordVisible when isConfirmPassword is true', () {
      final initialState = cubit.state;
      expect(initialState.confirmPasswordVisible, false);

      cubit.doIntent(TogglePasswordEvent(isConfirmPassword: true), context);

      expect(cubit.state.confirmPasswordVisible, true);
    });
  });
}
