import 'package:elevate_flower_app/core/utils/enums/Gender.dart';

sealed class RegisterEvents {
  const RegisterEvents();
  factory RegisterEvents.onGenderSelected(Gender? gender) =
      OnGenderSelectedEvent;
  factory RegisterEvents.registerUser() = RegisterUserEvent;

  void when({
    required void Function() registerUser,

    required void Function(Gender? gender) onGenderSelected,
  }) {
    if (this is RegisterUserEvent) {
      registerUser();
    } else if (this is OnGenderSelectedEvent) {
      onGenderSelected((this as OnGenderSelectedEvent).gender);
    }
  }
}

class OnGenderSelectedEvent extends RegisterEvents {
  final Gender? gender;
  const OnGenderSelectedEvent(this.gender);
}

class RegisterUserEvent extends RegisterEvents {
  const RegisterUserEvent();
}
