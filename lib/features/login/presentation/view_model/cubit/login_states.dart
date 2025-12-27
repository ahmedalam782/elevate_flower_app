import 'package:elevate_flower_app/core/config/base_state/base_state.dart';
import 'package:elevate_flower_app/features/login/domain/entities/login_response_entity.dart';

class LoginStates {
  LoginStates({this.loginState = const BaseState.initial()});

  BaseState<LoginResponseEntity> loginState;

  LoginStates copyWith({BaseState<LoginResponseEntity>? loginState}) {
    return LoginStates(loginState: loginState ?? this.loginState);
  }
}
