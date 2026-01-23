import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/config/base_state/base_state.dart';
import '../../../domain/use_cases/login_use_case.dart';
import 'login_events.dart';
import 'login_states.dart';

@injectable
class LoginCubit extends Cubit<LoginStates> {
  LoginCubit(this._loginUserUseCase) : super(LoginStates());
  
  final LoginUseCase _loginUserUseCase;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void doIntent(LoginEvents event) {
    event.when(loginUserEvent: _login);
  }

  void toggleRememberMe(bool value) {
    emit(state.copyWith(isRememberMe: value));
  }

  Future<void> _login() async {
    if (emailController.text.trim().isEmpty || 
        passwordController.text.isEmpty) {
      return;
    }
    
    emit(state.copyWith(loginState: const BaseState.loading()));
    final result = await _loginUserUseCase.call(
      email: emailController.text.trim(),
      password: passwordController.text,
      rememberMe: state.isRememberMe,
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
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}