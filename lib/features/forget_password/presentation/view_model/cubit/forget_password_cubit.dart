import 'dart:developer';
import '../../../../../core/config/base_response/result.dart';
import '../../../../../core/config/base_state/base_state.dart';
import '../../../../../core/shared/widgets/loading_flower_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/reset_password_dto/reset_password_dto.dart';
import '../../../domain/entities/forget_password_entity/forget_password_entity.dart';
import '../../../domain/use_cases/reset_password_use_case.dart';
import '../../../domain/use_cases/send_otp_to_email_use_case.dart';
import '../../../domain/use_cases/verify_otp_use_case.dart';
import 'forget_password_events.dart';
import 'forget_password_states.dart';
// import 'package:injectable/injectable.dart';

@injectable
class ForgetPasswordCubit extends Cubit<ForgetPasswordStates> {
  final SendOtpToEmailUseCase _sendOtpToEmailUseCase;
  final VerifyOtpUseCase _verifyOtpUseCase;
  final ResetPasswordUseCase _resetPasswordUseCase;
  bool showLoading = true;
  bool animatePage = true;

  ForgetPasswordCubit({
    required SendOtpToEmailUseCase sendOtpToEmailUseCase,
    required VerifyOtpUseCase verifyOtpUseCase,
    required ResetPasswordUseCase resetPasswordUseCase,
  }) : _sendOtpToEmailUseCase = sendOtpToEmailUseCase,
       _verifyOtpUseCase = verifyOtpUseCase,
       _resetPasswordUseCase = resetPasswordUseCase,
       super(const ForgetPasswordStates(isLoading: false));

  Future<void> doIntent(
    ForgetPasswordEvents event,
    BuildContext? context,
  ) async => switch (event) {
    SendOtpToEmailEvent() => _sendOtpToEmail(context),
    VerifyOtpEvent() => _verifyOtp(context, event.otp),
    TogglePasswordEvent() => _togglePassword(event.isConfirmPassword),
    ResetPasswordEvent() => _resetPassword(context),
  };
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final PageController pageController = PageController();

  void _emitLoadingState(BuildContext? context) {
    log("LOADING START");
    emit(state.copyWith(state: StateType.loading, isPasswordReset: false));
    if (showLoading && context != null) {
      showOverLayLoading();
    }
  }

  Future<void> _sendOtpToEmail(BuildContext? context) async {
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
    if (showLoading && context != null) {
      hideOverlayLoading();
    }
  }

  Future<void> _verifyOtp(BuildContext? context, String code) async {
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
    if (showLoading && context != null) {
      hideOverlayLoading();
    }
  }

  Future<void> _resetPassword(BuildContext? context) async {
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
    if (showLoading && context != null) {
      hideOverlayLoading();
    }
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
    if (!animatePage) return;
    pageController.animateToPage(
      page,
      curve: Curves.linear,
      duration: const Duration(milliseconds: 300),
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
