// TODO: presentation Product_detailsStates
import 'package:elevate_flower_app/core/config/base_state/base_state.dart';
import 'package:elevate_flower_app/features/product_details/domain/entities/specefic_product_entity.dart';

class ProductDetailsStates {
  final BaseState<SpeceficProductEntity> state;

  ProductDetailsStates({required this.state});

  ProductDetailsStates copyWith(BaseState<SpeceficProductEntity>? state) {
    return ProductDetailsStates(state: state ?? this.state);
  }
}
