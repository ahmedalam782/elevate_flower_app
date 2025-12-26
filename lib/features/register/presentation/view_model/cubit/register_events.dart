import 'package:elevate_flower_app/core/utils/enums/Gender.dart';

sealed class RegisterEvents {
  const RegisterEvents();
  factory RegisterEvents.onGenderSelected(Gender? gender) =
      OnGenderSelectedEvent;
  factory RegisterEvents.registerUser() = RegisterUserEvent;
  factory RegisterEvents.togglePasswordObscure() = TogglePasswordObscureEvent;
  factory RegisterEvents.toggleConfirmPasswordObscure() =
      ToggleConfirmPasswordObscureEvent;

  void when({
    required void Function() registerUser,
    required void Function() togglePasswordObscure,
    required void Function() toggleConfirmPasswordObscure,
    required void Function(Gender? gender) onGenderSelected,
  }) {
    if (this is RegisterUserEvent) {
      registerUser();
    } else if (this is TogglePasswordObscureEvent) {
      togglePasswordObscure();
    } else if (this is ToggleConfirmPasswordObscureEvent) {
      toggleConfirmPasswordObscure();
    } else if (this is OnGenderSelectedEvent) {
      onGenderSelected((this as OnGenderSelectedEvent).gender);
    }
  }
}

class TogglePasswordObscureEvent extends RegisterEvents {
  const TogglePasswordObscureEvent();
}

class ToggleConfirmPasswordObscureEvent extends RegisterEvents {
  const ToggleConfirmPasswordObscureEvent();
}

class OnGenderSelectedEvent extends RegisterEvents {
  final Gender? gender;
  const OnGenderSelectedEvent(this.gender);
}

class RegisterUserEvent extends RegisterEvents {
  const RegisterUserEvent();
}
