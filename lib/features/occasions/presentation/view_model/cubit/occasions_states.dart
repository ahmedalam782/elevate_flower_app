import 'package:elevate_flower_app/core/config/base_state/base_state.dart';
import 'package:elevate_flower_app/features/occasions/domain/entities/occasion_card_entity.dart';
import 'package:elevate_flower_app/features/occasions/domain/entities/product_card_entity.dart';
import 'package:equatable/equatable.dart';

class OccasionsStates extends Equatable {
  final BaseState<List<OccasionCardEntity>> occasions;
  final BaseState<List<ProductCardEntity>> productsByOccasion;
  const OccasionsStates({
    this.occasions = const BaseState.initial(),
    this.productsByOccasion = const BaseState.initial(),
  });

  @override
  List<Object> get props => [occasions, productsByOccasion];
  OccasionsStates copyWith({
    BaseState<List<OccasionCardEntity>>? occasions,
    BaseState<List<ProductCardEntity>>? productsByOccasion,
  }) => OccasionsStates(
    occasions: occasions ?? this.occasions,
    productsByOccasion: productsByOccasion ?? this.productsByOccasion,
  );
}
