import 'package:elevate_flower_app/core/config/base_state/base_state.dart';
import 'package:elevate_flower_app/core/utils/enums/Gender.dart';
import 'package:elevate_flower_app/features/register/domain/entities/register_user_response.dart';

class RegisterStates {
  RegisterStates({
    this.registerState = const BaseState.initial(),
    this.genderRowState = const GenderRowState(),
    PasswordFieldState? passwordFieldState,
    PasswordFieldState? confirmPasswordFieldState,
  }) : passwordFieldState = passwordFieldState ?? const PasswordFieldState(),
       confirmPasswordFieldState =
           confirmPasswordFieldState ?? const PasswordFieldState();
  final BaseState<RegisterUserResponse> registerState;
  final GenderRowState genderRowState;
  final PasswordFieldState passwordFieldState;
  final PasswordFieldState confirmPasswordFieldState;

  RegisterStates copyWith({
    BaseState<RegisterUserResponse>? registerState,
    GenderRowState? genderRowState,
    PasswordFieldState? passwordFieldState,
    PasswordFieldState? confirmPasswordFieldState,
  }) {
    return RegisterStates(
      registerState: registerState ?? this.registerState,
      genderRowState: genderRowState ?? this.genderRowState,
      passwordFieldState: passwordFieldState ?? this.passwordFieldState,
      confirmPasswordFieldState:
      confirmPasswordFieldState ?? this.confirmPasswordFieldState,
    );
  }
}

class GenderRowState {
  final bool showGenderError;
  final Gender? selectedGender;

  const GenderRowState({this.showGenderError = false, this.selectedGender});

  GenderRowState copyWith({bool? showGenderError, Gender? selectedGender}) {
    return GenderRowState(
      showGenderError: showGenderError ?? this.showGenderError,
      selectedGender: selectedGender ?? this.selectedGender,
    );
  }
}

class PasswordFieldState {
  final bool isObscure;
  final String? error;

  const PasswordFieldState({this.isObscure = true, this.error});

  PasswordFieldState copyWith({
    bool? isObscure,
    String? error,
    bool clearError = false,
  }) {
    return PasswordFieldState(
      isObscure: isObscure ?? this.isObscure,
      error: clearError ? null : error ?? this.error,
    );
  }
}
