import 'dart:developer';
import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/core/config/base_state/base_cubit.dart';
import 'package:elevate_flower_app/core/config/base_state/base_state.dart';
import 'package:elevate_flower_app/features/home/domain/entities/home_entity.dart';
import 'package:elevate_flower_app/features/home/domain/use_cases/get_home_data_usecase.dart';
import 'package:elevate_flower_app/features/home/presentation/view_model/cubit/home_events.dart';
import 'package:elevate_flower_app/features/home/presentation/view_model/cubit/home_states.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomeCubit extends BaseCubit<HomeStates, HomeEvents, void> {
  final GetHomeDataUsecase _getHomeDataUsecase;

  HomeCubit(this._getHomeDataUsecase) : super(HomeStates.initial());

  // ================== EVENTS ==================

  @override
  Future<void> doAction(HomeEvents event) async {
    switch (event) {
      case GetAllDataEvent():
        _getAllData();
        break;

      case GetCategoriesEvent():
        _getCategories();
        break;

      case GetBestSellerEvent():
        _getBestSeller();
        break;

      case GetOccasionEvent():
        _getOccasions();
        break;
    }
  }

  // ================== ALL ==================

  void _getAllData() async {
    emit(
      state.copyWith(
        categoryState: const BaseState.loading(),
        bestSellerState: const BaseState.loading(),
        occasionState: const BaseState.loading(),
      ),
    );

    Result<HomeEntity> res = await _getHomeDataUsecase();

    switch (res) {
      case Success<HomeEntity>():
        emit(
          state.copyWith(
            categoryState: BaseState.success(res.data?.categories),
            bestSellerState: BaseState.success(res.data?.bestSeller),
            occasionState: BaseState.success(res.data?.occasions),
          ),
        );

      case Error<HomeEntity>():
        log(res.exception.toString());
        emit(
          state.copyWith(
            categoryState: BaseState.error(res.exception),
            bestSellerState: BaseState.error(res.exception),
            occasionState: BaseState.error(res.exception),
          ),
        );
    }
  }

  // ================== CATEGORIES ==================

  Future<void> _getCategories() async {
    emit(state.copyWith(categoryState: const BaseState.loading()));

    Result<HomeEntity> res = await _getHomeDataUsecase();

    switch (res) {
      case Success<HomeEntity>():
        emit(
          state.copyWith(
            categoryState: BaseState.success(res.data?.categories),
          ),
        );

      case Error<HomeEntity>():
        log(res.exception.toString());
        emit(state.copyWith(categoryState: BaseState.error(res.exception)));
    }
  }

  // ================== BEST SELLER ==================

  Future<void> _getBestSeller() async {
    emit(state.copyWith(bestSellerState: const BaseState.loading()));

    Result<HomeEntity> res = await _getHomeDataUsecase();

    switch (res) {
      case Success<HomeEntity>():
        emit(
          state.copyWith(
            bestSellerState: BaseState.success(res.data?.bestSeller),
          ),
        );

      case Error<HomeEntity>():
        log(res.exception.toString());
        emit(state.copyWith(bestSellerState: BaseState.error(res.exception)));
    }
  }

  // ================== OCCASIONS ==================

  Future<void> _getOccasions() async {
    emit(state.copyWith(occasionState: const BaseState.loading()));

    Result<HomeEntity> res = await _getHomeDataUsecase();

    switch (res) {
      case Success<HomeEntity>():
        emit(
          state.copyWith(occasionState: BaseState.success(res.data?.occasions)),
        );

      case Error<HomeEntity>():
        log(res.exception.toString());
        emit(state.copyWith(occasionState: BaseState.error(res.exception)));
    }
  }

  @override
  void emit(HomeStates state) {
    if (isClosed) return;
    super.emit(state);
  }
}
