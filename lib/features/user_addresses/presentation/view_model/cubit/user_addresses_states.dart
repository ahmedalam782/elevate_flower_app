import 'package:elevate_flower_app/core/config/base_state/base_state.dart';
import 'package:elevate_flower_app/features/user_addresses/domain/entities/user_address_entity.dart';

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
