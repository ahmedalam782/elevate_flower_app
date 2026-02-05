import '../../../../../core/config/base_state/base_state.dart';
import '../../../domain/entities/user_address_entity.dart';

class UserAddressesStates {
  UserAddressesStates({this.getUserAddressesState = const BaseState.initial()});
  final BaseState<List<UserAddressEntity>> getUserAddressesState;

  UserAddressesStates copyWith({
    BaseState<List<UserAddressEntity>>? getUserAddressesState,
  }) {
    return UserAddressesStates(
      getUserAddressesState:
          getUserAddressesState ?? this.getUserAddressesState,
    );
  }
}
