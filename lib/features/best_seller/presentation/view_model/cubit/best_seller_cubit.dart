import 'package:elevate_flower_app/core/config/base_state/base_state.dart';
import 'package:elevate_flower_app/features/best_seller/domain/use_cases/get_best_seller_products_use_case.dart';
import 'package:elevate_flower_app/features/best_seller/presentation/view_model/cubit/best_seller_events.dart';
import 'package:elevate_flower_app/features/best_seller/presentation/view_model/cubit/best_seller_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class BestSellerCubit extends Cubit<BestSellerStates> {
  BestSellerCubit(this._getBestSellerProductsUseCase)
    : super(BestSellerStates());
  final GetBestSellerProductsUseCase _getBestSellerProductsUseCase;

  void doIntent(BestSellerEvents event) {
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
