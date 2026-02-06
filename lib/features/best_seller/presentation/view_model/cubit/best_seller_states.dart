import '../../../../../core/config/base_state/base_state.dart';
import '../../../domain/entities/best_seller_page_entity.dart';

class BestSellerStates {
  final BaseState<BestSellerPageEntity> getMostSellerState;

  BestSellerStates({this.getMostSellerState = const BaseState.initial()});

  BestSellerStates copyWith({
    BaseState<BestSellerPageEntity>? getMostSellerState,
  }) {
    return BestSellerStates(
      getMostSellerState: getMostSellerState ?? this.getMostSellerState,
    );
  }
}
