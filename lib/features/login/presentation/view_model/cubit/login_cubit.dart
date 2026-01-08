import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/config/base_state/base_state.dart';
import '../../../domain/use_cases/login_use_case.dart';
import 'login_events.dart';
import 'login_states.dart';

@injectable
class LoginCubit extends Cubit<LoginStates> {
  LoginCubit(this._loginUserUseCase, {this.formValidator})
    : super(LoginStates());

  final LoginUseCase _loginUserUseCase;
  final bool Function()? formValidator;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isRememberMe = false;

  void doIntent(LoginEvents event) {
    event.when(loginUserEvent: _validateThenLogin);
  }

  void _validateThenLogin() async {
    final isValid =
        formValidator?.call() ?? (formKey.currentState?.validate() ?? false);

    if (!isValid) return;

    emit(state.copyWith(loginState: const BaseState.loading()));

    final result = await _loginUserUseCase.call(
      email: emailController.text.trim(),
      password: passwordController.text,
      rememberMe: isRememberMe,
    );

    result.when(
      success: (data) {
        emit(state.copyWith(loginState: BaseState.success(data)));
      },
      error: (error) {
        emit(state.copyWith(loginState: BaseState.error(error)));
      },
    );
  }

  @override
  Future<void> close() {
    // ✅ امسح المحتوى الأول
    emailController.clear();
    passwordController.clear();
    // ✅ بعدين اعمل dispose
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
