import 'package:elevate_flower_app/core/config/base_state/base_state.dart';
import 'package:elevate_flower_app/features/login/domain/entities/login_response_entity.dart';

class LoginStates {
  LoginStates({
    this.loginState = const BaseState.initial(),
    this.isRememberMe = false,
  });

  BaseState<LoginResponseEntity> loginState;
  final bool isRememberMe;
  LoginStates copyWith({
    BaseState<LoginResponseEntity>? loginState,
    bool? isRememberMe,
  }) {
    return LoginStates(
      loginState: loginState ?? this.loginState,
      isRememberMe: isRememberMe ?? this.isRememberMe,
    );
  }
}
