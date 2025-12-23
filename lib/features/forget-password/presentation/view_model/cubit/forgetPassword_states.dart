import 'package:equatable/equatable.dart';

import 'package:elevate_flower_app/core/config/base_state/base_state.dart';
import 'package:elevate_flower_app/features/forget-password/domain/entities/forget_password_entity/forget_password_entity.dart';
import 'package:injectable/injectable.dart';

class ForgetpasswordStates extends Equatable {
  int currentScreen;
  bool isLoading;
  ForgetPasswordEntity? forgetPasswordEntity;
  StateType state;
  Exception? exception;
  bool newPasswordVisible;
  bool confirmPasswordVisible;
  bool isPasswordReset;

  ForgetpasswordStates({
    this.currentScreen = 0,
    this.isLoading = false,
    this.forgetPasswordEntity,
    this.state = StateType.initial,
    this.exception,
    this.newPasswordVisible = false,
    this.confirmPasswordVisible = false,
    this.isPasswordReset = false,
  });

  @override
  List<Object?> get props => [
    currentScreen,
    isLoading,
    forgetPasswordEntity,
    state,
    exception,
    newPasswordVisible,
    confirmPasswordVisible,
    isPasswordReset,
  ];

  ForgetpasswordStates copyWith({
    int? currentScreen,
    bool? isLoading,
    bool? confirmPasswordVisible,
    bool? newPasswordVisible,
    bool? isPasswordReset,
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
      newPasswordVisible: newPasswordVisible ?? this.newPasswordVisible,
      confirmPasswordVisible:
          confirmPasswordVisible ?? this.confirmPasswordVisible,
      isPasswordReset: isPasswordReset ?? this.isPasswordReset,
    );
  }
}
