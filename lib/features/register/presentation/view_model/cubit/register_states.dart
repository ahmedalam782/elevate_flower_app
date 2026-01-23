import 'package:elevate_flower_app/core/config/base_state/base_state.dart';
import 'package:elevate_flower_app/core/utils/enums/gender.dart';
import 'package:elevate_flower_app/features/register/domain/entities/register_user_response.dart';

class RegisterStates {
  RegisterStates({
    this.registerState = const BaseState.initial(),
    this.genderRowState = const GenderRowState(),
  });
  final BaseState<RegisterUserResponse> registerState;
  final GenderRowState genderRowState;

  RegisterStates copyWith({
    BaseState<RegisterUserResponse>? registerState,
    GenderRowState? genderRowState,
  }) {
    return RegisterStates(
      registerState: registerState ?? this.registerState,
      genderRowState: genderRowState ?? this.genderRowState,
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
