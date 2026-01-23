// TODO: presentation Product_detailsCubit

import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/core/config/base_state/base_state.dart';

import 'package:elevate_flower_app/features/cart/domain/use_cases/add_product_to_cart_use_case.dart';
import 'package:elevate_flower_app/features/product_details/domain/entities/specefic_product_entity.dart';
import 'package:elevate_flower_app/features/product_details/domain/use_cases/get_specefic_product_use_case.dart';
import 'package:elevate_flower_app/features/product_details/presentation/view_model/cubit/product_details_events.dart';
import 'package:elevate_flower_app/features/product_details/presentation/view_model/cubit/product_details_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProductDetailsCubit extends Cubit<ProductDetailsStates> {
  final GetSpeceficProductUseCase _getSpeceficProductUseCase;
  ProductDetailsCubit({
    required GetSpeceficProductUseCase getSpeceficProductUseCase,
    required AddProductToCartUseCase addSpeceficProductUseCase,
  }) : _getSpeceficProductUseCase = getSpeceficProductUseCase,
       super(
         ProductDetailsStates(
           state: const BaseState<SpeceficProductEntity>.initial(),
           isAddingProductToCart: false,
         ),
       );

  Future<dynamic> doIntent(ProductDetailsEvents event) async {
    switch (event) {
      case GetSpeceficProductEvent():
        return getSpeceficProduct(event.productId);
    }
  }

  Future<void> getSpeceficProduct(String productId) async {
    emit(
      state.copyWith(state: const BaseState<SpeceficProductEntity>.loading()),
    );
    final response = await _getSpeceficProductUseCase.call(productId);
    switch (response) {
      case Success<SpeceficProductEntity>():
        emit(state.copyWith(state: BaseState.success(response.data)));
      case Error<SpeceficProductEntity>():
        emit(state.copyWith(state: BaseState.error(response.exception)));
    }
  }
}
