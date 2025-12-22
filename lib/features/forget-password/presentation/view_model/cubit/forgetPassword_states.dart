import 'package:equatable/equatable.dart';

import 'package:elevate_flower_app/core/config/base_state/base_state.dart';
import 'package:elevate_flower_app/features/forget-password/domain/entities/forget_password_entity/forget_password_entity.dart';
import 'package:injectable/injectable.dart';

class ForgetpasswordStates extends Equatable {
  final int currentScreen;
  final bool isLoading;
  final ForgetPasswordEntity? forgetPasswordEntity;
  final StateType state;
  final Exception? exception;

  const ForgetpasswordStates({
    this.currentScreen = 0,
    this.isLoading = false,
    this.forgetPasswordEntity,
    this.state = StateType.initial,
    this.exception,
  });

  @override
  List<Object?> get props => [
    currentScreen,
    isLoading,
    forgetPasswordEntity,
    state,
    exception,
  ];

  ForgetpasswordStates copyWith({
    int? currentScreen,
    bool? isLoading,
    ForgetPasswordEntity? forgetPasswordEntity,
    StateType? state,
    Exception? exception,
  }) {
    return ForgetpasswordStates(
      currentScreen: currentScreen ?? this.currentScreen,
      isLoading: isLoading ?? this.isLoading,
      forgetPasswordEntity: forgetPasswordEntity ?? this.forgetPasswordEntity,
      state: state ?? this.state,
      exception: exception ?? this.exception,
    );
  }
}
