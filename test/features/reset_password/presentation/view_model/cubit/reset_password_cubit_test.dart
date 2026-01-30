import 'package:bloc_test/bloc_test.dart';
import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/core/config/base_state/base_state.dart';
import 'package:elevate_flower_app/features/reset_password/domain/entities/change_password_entity.dart';
import 'package:elevate_flower_app/features/reset_password/domain/use_cases/change_password_usecase.dart';
import 'package:elevate_flower_app/features/reset_password/presentation/view_model/cubit/reset_password_cubit.dart';
import 'package:elevate_flower_app/features/reset_password/presentation/view_model/cubit/reset_password_events.dart';
import 'package:elevate_flower_app/features/reset_password/presentation/view_model/cubit/reset_password_states.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'reset_password_cubit_test.mocks.dart';

@GenerateMocks([ChangePasswordUseCase])
void main() {
  late ResetPasswordCubit cubit;
  late MockChangePasswordUseCase mockUseCase;

  setUp(() {
    mockUseCase = MockChangePasswordUseCase();
    cubit = ResetPasswordCubit(mockUseCase);
  });

  tearDown(() {
    cubit.close();
  });

  group('ResetPasswordCubit', () {
    const tCurrentPassword = 'password123';
    // Valid password (8+ chars, uppercase, no special char check? wait let me check the cubit logic again)
    // Cubit logic:
    // - != confirm -> "Passwords do not match"
    // - < 8 chars -> "Password must be at least 8 characters"
    // - no uppercase -> "Password must contain at least one uppercase letter"
    // - no number -> "Password must contain at least one number"
    // - no special -> "Password must contain at least one special character"

    // So a valid password needs: 8+ chars, 1 uppercase, 1 number, 1 special char.
    const tNewPassword = 'NewPassword123!';
    const tConfirmPassword = 'NewPassword123!';

    final tEntity = ChangePasswordEntity(message: 'Success', token: 'token');

    test('initial state should be ResetPasswordStates()', () {
      expect(cubit.state, const ResetPasswordStates());
    });

    blocTest<ResetPasswordCubit, ResetPasswordStates>(
      'should emit [error] when passwords do not match',
      build: () => cubit,
      act: (cubit) => cubit.doIntent(
        ResetPasswordEvents.changePassword(
          currentPassword: tCurrentPassword,
          newPassword: tNewPassword,
          confirmPassword: 'DifferentPassword',
        ),
      ),
      expect: () => [
        isA<ResetPasswordStates>().having(
          (state) => state.changePasswordState.state,
          'changePasswordState.state',
          StateType.error,
        ),
      ],
    );

    blocTest<ResetPasswordCubit, ResetPasswordStates>(
      'should emit [error] when password is too short',
      build: () => cubit,
      act: (cubit) => cubit.doIntent(
        ResetPasswordEvents.changePassword(
          currentPassword: tCurrentPassword,
          newPassword: 'Short!',
          confirmPassword: 'Short!',
        ),
      ),
      expect: () => [
        isA<ResetPasswordStates>().having(
          (state) => state.changePasswordState.state,
          'changePasswordState.state',
          StateType.error,
        ),
      ],
    );

    blocTest<ResetPasswordCubit, ResetPasswordStates>(
      'should emit [loading, success] when data is gotten successfully',
      build: () {
        when(
          mockUseCase(
            currentPassword: anyNamed('currentPassword'),
            newPassword: anyNamed('newPassword'),
          ),
        ).thenAnswer((_) async => Success(data: tEntity));
        return cubit;
      },
      act: (cubit) => cubit.doIntent(
        ResetPasswordEvents.changePassword(
          currentPassword: tCurrentPassword,
          newPassword: tNewPassword,
          confirmPassword: tConfirmPassword,
        ),
      ),
      wait: const Duration(milliseconds: 300),
      expect: () => [
        isA<ResetPasswordStates>().having(
          (state) => state.changePasswordState.state,
          'changePasswordState.state',
          StateType.loading,
        ),
        isA<ResetPasswordStates>().having(
          (state) => state.changePasswordState.state,
          'changePasswordState.state',
          StateType.success,
        ),
      ],
    );

    blocTest<ResetPasswordCubit, ResetPasswordStates>(
      'should emit [loading, error] when getting data fails',
      build: () {
        when(
          mockUseCase(
            currentPassword: anyNamed('currentPassword'),
            newPassword: anyNamed('newPassword'),
          ),
        ).thenAnswer((_) async => Error(exception: Exception('Error')));
        return cubit;
      },
      act: (cubit) => cubit.doIntent(
        ResetPasswordEvents.changePassword(
          currentPassword: tCurrentPassword,
          newPassword: tNewPassword,
          confirmPassword: tConfirmPassword,
        ),
      ),
      wait: const Duration(milliseconds: 300),
      expect: () => [
        isA<ResetPasswordStates>().having(
          (state) => state.changePasswordState.state,
          'changePasswordState.state',
          StateType.loading,
        ),
        isA<ResetPasswordStates>().having(
          (state) => state.changePasswordState.state,
          'changePasswordState.state',
          StateType.error,
        ),
      ],
    );
  });
}
