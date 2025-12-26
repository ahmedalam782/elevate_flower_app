

import 'package:equatable/equatable.dart';

import '../../../../../core/config/base_state/base_state.dart';
import '../../../domain/entities/forget_password_entity/forget_password_entity.dart';

class ForgetPasswordStates extends Equatable {
 final int currentScreen;
  final bool isLoading;
  final ForgetPasswordEntity? forgetPasswordEntity;
  final StateType state;
  final Exception? exception;
  final bool newPasswordVisible;
  final bool confirmPasswordVisible;
  final bool isPasswordReset;

  const ForgetPasswordStates({
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

  ForgetPasswordStates copyWith({
    int? currentScreen,
    bool? isLoading,
    bool? confirmPasswordVisible,
    bool? newPasswordVisible,
    bool? isPasswordReset,
    ForgetPasswordEntity? forgetPasswordEntity,
    StateType? state,
    Exception? exception,
  }) {
    return ForgetPasswordStates(
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
