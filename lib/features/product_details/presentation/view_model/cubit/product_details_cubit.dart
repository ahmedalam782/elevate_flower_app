// TODO: presentation Product_detailsCubit

import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/core/config/base_state/base_state.dart';
import 'package:elevate_flower_app/core/errors/failures.dart';
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
  }) : _getSpeceficProductUseCase = getSpeceficProductUseCase,
       super(
         ProductDetailsStates(
           state: const BaseState<SpeceficProductEntity>.initial(),
         ),
       );

  Future<void> doIntent(ProductDetailsEvents event) async => switch (event) {
    GetSpeceficProductEvent() => getSpeceficProduct(event.productId),
  };

  Future<void> getSpeceficProduct(String productId) async {
    // print("PRODUCT ID ${productId}");
    emit(state.copyWith(const BaseState<SpeceficProductEntity>.loading()));
    final response = await _getSpeceficProductUseCase.call(productId);
    switch (response) {
      case Success<SpeceficProductEntity>():
        emit(state.copyWith(BaseState.success(response.data)));
      case Error<SpeceficProductEntity>():
        emit(state.copyWith(BaseState.error(response.exception)));
        if (response.exception is Failures) {
          final ex = response.exception as Failures;
          print(ex.errorMessage);
        }
    }
  }
}
