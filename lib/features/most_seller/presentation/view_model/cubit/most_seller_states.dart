import 'package:elevate_flower_app/core/config/base_state/base_state.dart';

class MostSellerStates {

  final BaseState getMostSellerState;

      MostSellerStates({
     this.getMostSellerState = const BaseState.initial(),
  });

  MostSellerStates copyWith({
    BaseState? getMostSellerState,
  }) {
    return MostSellerStates(
      getMostSellerState: getMostSellerState ?? this.getMostSellerState,
    );
  }
  
}
