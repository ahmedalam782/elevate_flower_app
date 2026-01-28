import 'package:elevate_flower_app/core/config/base_state/base_state.dart';

class UserAdressesStates {
  UserAdressesStates({this.getUserAdressesState = const BaseState.initial()});
  final BaseState getUserAdressesState;

  UserAdressesStates copyWith({BaseState? getUserAdressesState}) {
    return UserAdressesStates(
      getUserAdressesState: getUserAdressesState ?? this.getUserAdressesState,
    );
  }
}
