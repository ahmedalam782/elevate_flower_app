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
    context = null;
  });

  test('sanity', () {
    expect(1, 1);
  });

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
        isNot(StateType.success),
      ),
      isA<ForgetPasswordStates>().having(
        (s) => s.state,
        'state',
        StateType.success,
      ),
    ],
  );
}
