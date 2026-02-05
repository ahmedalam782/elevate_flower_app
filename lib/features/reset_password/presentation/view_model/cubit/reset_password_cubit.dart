import '../../../domain/use_cases/change_password_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/config/base_state/base_state.dart';
import 'reset_password_events.dart';
import 'reset_password_states.dart';

@injectable
class ResetPasswordCubit extends Cubit<ResetPasswordStates> {
  final ChangePasswordUseCase _changePasswordUseCase;

  ResetPasswordCubit(this._changePasswordUseCase)
    : super(const ResetPasswordStates());

  // ✅ Form Key
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // ✅ Controllers
  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  // ✅ Dispose Controllers
  @override
  Future<void> close() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }

  Future<void> doIntent(ResetPasswordEvents event) async {
    await event.when(changePassword: _changePassword);
  }

  Future<void> _changePassword(
    String currentPassword,
    String newPassword,
    String confirmPassword,
  ) async {
    // Validation: Check if passwords match
    if (newPassword != confirmPassword) {
      emit(
        state.copyWith(
          changePasswordState: BaseState.error(
            Exception('Passwords do not match'),
          ),
        ),
      );
      return;
    }

    // Check password strength
    if (newPassword.length < 8) {
      emit(
        state.copyWith(
          changePasswordState: BaseState.error(
            Exception('Password must be at least 8 characters'),
          ),
        ),
      );
      return;
    }

    // Check if password contains at least one uppercase letter
    if (!newPassword.contains(RegExp(r'[A-Z]'))) {
      emit(
        state.copyWith(
          changePasswordState: BaseState.error(
            Exception('Password must contain at least one uppercase letter'),
          ),
        ),
      );
      return;
    }

    // Check if password contains at least one number
    if (!newPassword.contains(RegExp(r'[0-9]'))) {
      emit(
        state.copyWith(
          changePasswordState: BaseState.error(
            Exception('Password must contain at least one number'),
          ),
        ),
      );
      return;
    }

    // Check if password contains special character
    if (!newPassword.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      emit(
        state.copyWith(
          changePasswordState: BaseState.error(
            Exception('Password must contain at least one special character'),
          ),
        ),
      );
      return;
    }

    emit(state.copyWith(changePasswordState: const BaseState.loading()));

    final result = await _changePasswordUseCase(
      currentPassword: currentPassword,
      newPassword: newPassword,
    );

    result.when(
      success: (data) {
        emit(state.copyWith(changePasswordState: BaseState.success(data)));
      },
      error: (exception) {
        emit(state.copyWith(changePasswordState: BaseState.error(exception)));
      },
    );
  }
}
