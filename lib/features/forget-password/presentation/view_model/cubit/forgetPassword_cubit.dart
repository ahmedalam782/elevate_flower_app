// TODO: presentation ForgetPasswordCubit

import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/core/config/base_state/base_state.dart';
import 'package:elevate_flower_app/core/shared/widgets/loading_flower_widget.dart';
import 'package:elevate_flower_app/features/forget-password/domain/entities/forget_password_entity/forget_password_entity.dart';
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

  ForgetpasswordCubit({
    required SendOtpToEmailUseCase signupUserUsecase,
    required VerifyOtpUseCase verifyOtpUseCase,
  }) : _sendOtpToEmailUseCase = signupUserUsecase,
       _verifyOtpUseCase = verifyOtpUseCase,
       super(ForgetpasswordStates(isLoading: false));

  Future<void> doIntent(
    ForgetpasswordEvents event,
    BuildContext context,
  ) async => switch (event) {
    // TODO: Handle this case.
    SendOtpToEmailEvent() => _sendOtpToEmail(context),
    // TODO: Handle this case.
    VerifyOtpEvent() => _verifyOtp(context, event.otp),
  };
  final TextEditingController emailController = TextEditingController();
  final PageController pageController = PageController();

  void _emitLoadingState(BuildContext context) {
    emit(state.copyWith(state: StateType.loading));

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
        animateToPage(state.currentScreen);
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
        animateToPage(state.currentScreen);
      case Error<void>():
        emit(
          state.copyWith(state: StateType.error, exception: result.exception),
        );
    }
    hideOverlayLoading(context);
  }

  void animateToPage(int page) {
    pageController.animateToPage(
      // duration: Duration(milliseconds: 300),
      page,
      curve: Curves.linear,
      duration: Duration(milliseconds: 300),
    );
  }

  @override
  Future<void> close() {
    for (final controller in [emailController]) {
      controller.dispose();
    }
    return super.close();
  }
}
