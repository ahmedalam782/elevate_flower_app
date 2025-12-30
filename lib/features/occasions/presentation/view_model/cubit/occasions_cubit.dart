import 'dart:developer';

import 'package:elevate_flower_app/core/config/base_state/base_state.dart';
import 'package:elevate_flower_app/features/occasions/domain/use_cases/get_occasions_use_case.dart';
import 'package:elevate_flower_app/features/occasions/domain/use_cases/get_products_by_occasion_use_case.dart';
import 'package:elevate_flower_app/features/occasions/presentation/view_model/cubit/occasions_events.dart';
import 'package:elevate_flower_app/features/occasions/presentation/view_model/cubit/occasions_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class OccasionsCubit extends Cubit<OccasionsStates> {
  String selectedOccasionId = '';
  final GetOccasionsUseCase _getOccasionsUseCase;
  final GetProductsByOccasionUseCase _getProductsByOccasionUseCase;
  OccasionsCubit(this._getOccasionsUseCase, this._getProductsByOccasionUseCase)
    : super(const OccasionsStates());

  void doIntent(OccasionsEvents event) {
    log(event.toString());
    event.when(
      getOccasions: _getOccasions,
      getFlowersByOccasions: _getFlowersByOccasion,
    );
  }

  Future<void> _getOccasions() async {
    log("Getting occasions...");
    emit(state.copyWith(occasions: const BaseState.loading()));
    final result = await _getOccasionsUseCase.call();
    result.when(
      success: (data) {
        emit(state.copyWith(occasions: BaseState.success(data)));
        _getFlowersByOccasion(data?.first.id ?? '');
      },
      error: (exception) {
        emit(state.copyWith(occasions: BaseState.error(exception)));
      },
    );
  }

  Future<void> _getFlowersByOccasion(String occasionId) async {
    selectedOccasionId = occasionId;
    emit(state.copyWith(productsByOccasion: const BaseState.loading()));
    final result = await _getProductsByOccasionUseCase.call(occasionId);
    result.when(
      success: (data) {
        emit(state.copyWith(productsByOccasion: BaseState.success(data)));
      },
      error: (exception) {
        emit(state.copyWith(productsByOccasion: BaseState.error(exception)));
      },
    );
  }
}
