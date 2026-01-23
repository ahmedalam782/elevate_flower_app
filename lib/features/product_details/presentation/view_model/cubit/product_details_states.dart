// ignore_for_file: public_member_api_docs, sort_constructors_first
// TODO: presentation Product_detailsStates
import 'package:elevate_flower_app/core/config/base_state/base_state.dart';
import 'package:elevate_flower_app/features/product_details/domain/entities/specefic_product_entity.dart';

class ProductDetailsStates {
  final BaseState<SpeceficProductEntity> state;
  bool isAddingProductToCart;

  ProductDetailsStates({
    required this.state,
    required this.isAddingProductToCart,
  });

  ProductDetailsStates copyWith({
    BaseState<SpeceficProductEntity>? state,
    bool? isAddingProductToCart,
  }) {
    return ProductDetailsStates(
      state: state ?? this.state,
      isAddingProductToCart:
          isAddingProductToCart ?? this.isAddingProductToCart,
    );
  }
}
