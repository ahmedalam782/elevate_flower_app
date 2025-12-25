import 'package:elevate_flower_app/core/config/base_state/base_state.dart';
import 'package:elevate_flower_app/features/login/data/models/login_response_model.dart';

class LoginStates {
  LoginStates({this.loginState = const BaseState.initial()});

  BaseState<LoginResponseModel> loginState;

  LoginStates copyWith({BaseState<LoginResponseModel>? loginState}) {
    return LoginStates(loginState: loginState ?? this.loginState);
  }
}
