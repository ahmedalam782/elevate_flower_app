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
    return HomeStates(
      categoryState: const BaseState.initial(),
      bestSellerState: const BaseState.initial(),
      occasionState: const BaseState.initial(),
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











// import 'package:elevate_flower_app/core/config/base_state/base_state.dart';
// import 'package:elevate_flower_app/features/home/data/models/product_model.dart';
// import 'package:elevate_flower_app/features/home/domain/entities/category_entity.dart';
// import 'package:elevate_flower_app/features/home/domain/entities/occasion_entity.dart';
// import 'package:elevate_flower_app/features/home/domain/entities/product_entity.dart';

// class HomeStates {
//   BaseState<List<CategoryEntity>>? categoryState;
//   BaseState<List<ProductEntity>>? bestSellerState;
//   BaseState<List<OccasionEntity>>? occasionState;
//   HomeStates({this.bestSellerState, this.categoryState, this.occasionState});
//   HomeStates copyWith({
//     BaseState<List<CategoryEntity>>? categoryStatePram,
//     BaseState<List<ProductEntity>>? bestSellerStatePram,
//     BaseState<List<OccasionEntity>>? occasionStatePram,
//   }) {
//     return HomeStates(
//       categoryState: categoryStatePram ?? categoryState,
//       bestSellerState: bestSellerStatePram ?? bestSellerState,
//       occasionState: occasionStatePram ?? occasionState,
//     );
//   }
// }
