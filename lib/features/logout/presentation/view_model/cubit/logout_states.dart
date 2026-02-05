import '../../../../../core/config/base_state/base_state.dart';
import '../../../data/models/logout_response_model.dart';
import 'package:equatable/equatable.dart';

class LogoutStates extends Equatable {
  final BaseState<LogoutResponseModel> logoutState;

  const LogoutStates({
    required this.logoutState,
  });

  const LogoutStates.initial()
      : logoutState = const BaseState.initial();

  LogoutStates copyWith({
    BaseState<LogoutResponseModel>? logoutState,
  }) {
    return LogoutStates(
      logoutState: logoutState ?? this.logoutState,
    );
  }

  @override
  List<Object?> get props => [logoutState];
}