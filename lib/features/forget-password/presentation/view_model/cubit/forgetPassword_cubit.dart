// TODO: presentation ForgetPasswordCubit

import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/core/config/base_state/base_state.dart';
import 'package:elevate_flower_app/core/shared/widgets/loading_flower_widget.dart';
import 'package:elevate_flower_app/features/forget-password/data/models/reset_password_dto/reset_password_dto.dart';
import 'package:elevate_flower_app/features/forget-password/domain/entities/forget_password_entity/forget_password_entity.dart';
import 'package:elevate_flower_app/features/forget-password/domain/use_cases/reset_password_use_case.dart';
import 'package:elevate_flower_app/features/forget-password/domain/use_cases/send_otp_to_email_use_case.dart';
import 'package:elevate_flower_app/features/forget-password/domain/use_cases/verify_otp_use_case.dart';
import 'package:elevate_flower_app/features/forget-password/presentation/view_model/cubit/forgetPassword_events.dart';
import 'package:elevate_flower_app/features/forget-password/presentation/view_model/cubit/forgetPassword_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
// import 'package:injectable/injectable.dart';

@Injectable()
class ForgetpasswordCubit extends Cubit<ForgetpasswordStates> {
  final SendOtpToEmailUseCase _sendOtpToEmailUseCase;
  final VerifyOtpUseCase _verifyOtpUseCase;
  final ResetPasswordUseCase _resetPasswordUseCase;

  ForgetpasswordCubit({
    required SendOtpToEmailUseCase signupUserUsecase,
    required VerifyOtpUseCase verifyOtpUseCase,
    required ResetPasswordUseCase resetPasswordUseCase,
  }) : _sendOtpToEmailUseCase = signupUserUsecase,
       _verifyOtpUseCase = verifyOtpUseCase,
       _resetPasswordUseCase = resetPasswordUseCase,
       super(ForgetpasswordStates(isLoading: false));

  Future<void> doIntent(
    ForgetpasswordEvents event,
    BuildContext context,
  ) async => switch (event) {
    SendOtpToEmailEvent() => _sendOtpToEmail(context),
    VerifyOtpEvent() => _verifyOtp(context, event.otp),
    TogglePasswordEvent() => _togglePassword(event.isConfirmPassword),
    // TODO: Handle this case.
    ResetPasswordEvent() => _resetPassword(context),
  };
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final PageController pageController = PageController();

  void _emitLoadingState(BuildContext context) {
    print("LOADING START");
    emit(state.copyWith(state: StateType.loading, isPasswordReset: false));

    showOverLayLoading(context);
  }

  Future<void> _sendOtpToEmail(BuildContext context) async {
    _emitLoadingState(context);
    final result = await _sendOtpToEmailUseCase.call(emailController.text);
    switch (result) {
      case Success<ForgetPasswordEntity>():
        emit(
          state.copyWith(
            forgetPasswordEntity: result.data,
            currentScreen: 1,
            state: StateType.success,
          ),
        );
        _animateToPage(state.currentScreen);
      case Error<ForgetPasswordEntity>():
        emit(
          state.copyWith(state: StateType.error, exception: result.exception),
        );
    }
    hideOverlayLoading(context);
  }

  Future<void> _verifyOtp(BuildContext context, String code) async {
    _emitLoadingState(context);

    final result = await _verifyOtpUseCase.call(code);
    switch (result) {
      case Success<void>():
        emit(state.copyWith(currentScreen: 2, state: StateType.success));
        _animateToPage(state.currentScreen);
      case Error<void>():
        emit(
          state.copyWith(state: StateType.error, exception: result.exception),
        );
    }
    hideOverlayLoading(context);
  }

  Future<void> _resetPassword(BuildContext context) async {
    _emitLoadingState(context);

    final result = await _resetPasswordUseCase.call(
      ResetPasswordDTo(
        email: emailController.text,
        newPassword: passwordController.text,
      ),
    );
    switch (result) {
      case Success<void>():
        emit(state.copyWith(state: StateType.success, isPasswordReset: true));
      case Error<void>():
        emit(
          state.copyWith(state: StateType.error, exception: result.exception),
        );
    }
    hideOverlayLoading(context);
  }

  Future<void> _togglePassword(bool isConfirmPassword) async {
    if (isConfirmPassword) {
      emit(
        state.copyWith(confirmPasswordVisible: !state.confirmPasswordVisible),
      );
    } else {
      emit(state.copyWith(newPasswordVisible: !state.newPasswordVisible));
    }
  }

  void _animateToPage(int page) {
    pageController.animateToPage(
      // duration: Duration(milliseconds: 300),
      page,
      curve: Curves.linear,
      duration: Duration(milliseconds: 300),
    );
  }

  @override
  Future<void> close() {
    for (final controller in [
      emailController,
      passwordController,
      confirmPasswordController,
      pageController,
    ]) {
      controller.dispose();
    }
    return super.close();
  }
}
