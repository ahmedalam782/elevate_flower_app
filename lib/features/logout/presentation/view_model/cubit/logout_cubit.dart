import 'dart:developer';
import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/core/config/base_state/base_cubit.dart';
import 'package:elevate_flower_app/core/config/base_state/base_state.dart';
import 'package:elevate_flower_app/core/helper/user_helper/user_helper.dart';
import 'package:elevate_flower_app/features/logout/data/models/logout_response_model.dart';
import 'package:elevate_flower_app/features/logout/domain/use_cases/logout_usecase.dart';
import 'package:elevate_flower_app/features/logout/presentation/view_model/cubit/logout_events.dart';
import 'package:elevate_flower_app/features/logout/presentation/view_model/cubit/logout_navigation.dart';
import 'package:elevate_flower_app/features/logout/presentation/view_model/cubit/logout_states.dart';
import 'package:injectable/injectable.dart';

@injectable
class LogoutCubit
    extends BaseCubit<LogoutStates, LogoutEvents, LogoutNavigationAction> {
  final LogoutUseCase _logoutUseCase;

  LogoutCubit(this._logoutUseCase) : super(const LogoutStates.initial());

  // ================== EVENTS ==================

  @override
  Future<void> doAction(LogoutEvents event) async {
    switch (event) {
      case LogoutUserEvent():
        _logout();
        break;
    }
  }

  // ================== LOGOUT ==================

  Future<void> _logout() async {
    emit(state.copyWith(logoutState: const BaseState.loading()));

    Result<LogoutResponseModel> res = await _logoutUseCase();

    switch (res) {
      case Success<LogoutResponseModel>():
        log('Logout successful: ${res.data?.message}');
        emit(state.copyWith(logoutState: BaseState.success(res.data)));

        // Clear user data and navigate to login page
        await UserHelper.clearUserData();

      case Error<LogoutResponseModel>():
        log('Logout error: ${res.exception.toString()}');
        emit(state.copyWith(logoutState: BaseState.error(res.exception)));
    }
  }
}
