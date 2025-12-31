import 'package:elevate_flower_app/core/config/base_state/base_state.dart';
import 'package:elevate_flower_app/features/most_seller/domain/use_cases/get_best_seller_products_use_case.dart';
import 'package:elevate_flower_app/features/most_seller/presentation/view_model/cubit/most_seller_events.dart';
import 'package:elevate_flower_app/features/most_seller/presentation/view_model/cubit/most_seller_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MostSellerCubit extends Cubit<MostSellerStates> {
  MostSellerCubit(this._getBestSellerProductsUseCase)
    : super(MostSellerStates());
  final GetBestSellerProductsUseCase _getBestSellerProductsUseCase;

  void doIntent(MostSellerEvents event) {
    event.when(getBestSellerProducts: _getBestSellerProducts);
  }

  Future<void> _getBestSellerProducts() async {
    emit(state.copyWith(getMostSellerState: const BaseState.loading()));
    final result = await _getBestSellerProductsUseCase();
    result.when(
      success: (data) {
        emit(state.copyWith(getMostSellerState: BaseState.success(data)));
      },
      error: (exception) {
        emit(state.copyWith(getMostSellerState: BaseState.error(exception)));
      },
    );
  }
}
