import 'package:elevate_flower_app/core/config/base_state/base_state.dart';
import 'package:elevate_flower_app/features/home/domain/entities/category_entity.dart';
import 'package:elevate_flower_app/features/home/domain/entities/occasion_entity.dart';
import 'package:elevate_flower_app/features/home/domain/entities/product_entity.dart';

class HomeStates {
  final BaseState<List<CategoryEntity>> categoryState;
  final BaseState<List<ProductEntity>> bestSellerState;
  final BaseState<List<OccasionEntity>> occasionState;

  const HomeStates({
    required this.categoryState,
    required this.bestSellerState,
    required this.occasionState,
  });

  factory HomeStates.initial() {
    return const HomeStates(
      categoryState: BaseState.initial(),
      bestSellerState: BaseState.initial(),
      occasionState: BaseState.initial(),
    );
  }

  HomeStates copyWith({
    BaseState<List<CategoryEntity>>? categoryState,
    BaseState<List<ProductEntity>>? bestSellerState,
    BaseState<List<OccasionEntity>>? occasionState,
  }) {
    return HomeStates(
      categoryState: categoryState ?? this.categoryState,
      bestSellerState: bestSellerState ?? this.bestSellerState,
      occasionState: occasionState ?? this.occasionState,
    );
  }
}
