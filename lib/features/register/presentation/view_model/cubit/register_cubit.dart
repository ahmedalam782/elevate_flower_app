import '../../../../../core/config/base_state/base_state.dart';
import '../../../../../core/utils/enums/gender.dart';
import '../../../domain/entities/register_params.dart';
import '../../../domain/use_cases/register_user_user_case.dart';
import '../../../domain/use_cases/save_token_use_case.dart';
import 'register_events.dart';
import 'register_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

typedef FormValidator = bool Function();

@injectable
class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit(
    this._registerUserUseCase,
    this._saveTokenUseCase, {
    @factoryParam this.formValidator,
  }) : super(RegisterStates());
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final RegisterUserUseCase _registerUserUseCase;
  final SaveTokenUseCase _saveTokenUseCase;
  final _countryCode = '+2';
  final FormValidator? formValidator; // to avoid using form validaation in test

  void doIntent(RegisterEvents event) {
    event.when(
      registerUser: _registerUser,
      onGenderSelected: _onGenderSelected,
    );
  }

  void _onGenderSelected(Gender? gender) {
    emit(
      state.copyWith(
        genderRowState: state.genderRowState.copyWith(
          selectedGender: gender,
          showGenderError: gender == null ? true : false,
        ),
      ),
    );
  }

  bool _isFormValid() {
    return formValidator?.call() ?? (formKey.currentState?.validate() ?? false);
  }

  void _registerUser() async {
    final isGenderSelected = state.genderRowState.selectedGender != null;
    if (!_isFormValid() || !isGenderSelected) {
      // Show error message
      if (!isGenderSelected) {
        emit(
          state.copyWith(
            genderRowState: state.genderRowState.copyWith(
              showGenderError: true,
            ),
          ),
        );
      }
      return;
    }

    final params = RegisterParams(
      firstName: nameController.text.trim(),
      lastName: lastNameController.text.trim(),
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
      passwordConfirmation: confirmPasswordController.text.trim(),
      phoneNumber: _countryCode + phoneController.text.trim(),
      gender: state.genderRowState.selectedGender!.name,
    );

    emit(state.copyWith(registerState: const BaseState.loading()));
    final result = await _registerUserUseCase(params);
    result.when(
      success: (data) async {
        if (data != null && data.token != null) {
          await _saveTokenUseCase(data.token!);
        }
        emit(state.copyWith(registerState: BaseState.success(data)));
      },
      error: (message) {
        emit(state.copyWith(registerState: BaseState.error(message)));
      },
    );
  }

  @override
  Future<void> close() {
    nameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneController.dispose();
    return super.close();
  }
}
