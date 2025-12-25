import 'package:easy_localization/easy_localization.dart';
import 'package:elevate_flower_app/core/languages/locale_keys.g.dart';
import 'package:elevate_flower_app/core/shared/widgets/custom_text_field.dart';
import 'package:elevate_flower_app/core/theme/app_colors.dart';
import 'package:elevate_flower_app/core/validations/validations.dart';
import 'package:elevate_flower_app/features/register/presentation/view_model/cubit/register_cubit.dart';
import 'package:elevate_flower_app/features/register/presentation/view_model/cubit/register_events.dart';
import 'package:elevate_flower_app/features/register/presentation/view_model/cubit/register_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});
  static const String countryCode = '+20';
  static const double rowPadding = 16.0;
  static const double formPadding = 24.0;
  static const int phoneLength = 10;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RegisterCubit>();
    return Form(
      key: cubit.formKey,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: rowPadding,
            children: [
              Expanded(
                child: CustomTextField(
                  controller: cubit.nameController,
                  hintText: LocaleKeys.register_first_name_hint.tr(),
                  labelWidget: Text(LocaleKeys.register_first_name_label.tr()),
                  textInputType: TextInputType.name,
                  autovalidateMode: AutovalidateMode.disabled,
                  validator: (value) {
                    return Validations.validateFirstName(value);
                  },
                ),
              ),
              Expanded(
                child: CustomTextField(
                  controller: cubit.lastNameController,
                  hintText: LocaleKeys.register_last_name_hint.tr(),
                  labelWidget: Text(LocaleKeys.register_last_name_label.tr()),
                  textInputType: TextInputType.name,
                  autovalidateMode: AutovalidateMode.disabled,
                  validator: (value) {
                    return Validations.validateLastName(value);
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: formPadding),
          CustomTextField(
            controller: cubit.emailController,
            hintText: LocaleKeys.register_email_hint.tr(),
            labelWidget: Text(LocaleKeys.register_email_label.tr()),
            textInputType: TextInputType.emailAddress,
            autovalidateMode: AutovalidateMode.disabled,
            validator: (value) {
              return Validations.validateEmail(value);
            },
          ),
          SizedBox(height: formPadding),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: rowPadding,
            children: [
              Expanded(
                child:
                    BlocSelector<
                      RegisterCubit,
                      RegisterStates,
                      PasswordFieldState
                    >(
                      selector: (state) {
                        return state.passwordFieldState;
                      },
                      builder: (context, state) {
                        return CustomTextField(
                          controller: cubit.passwordController,
                          hintText: LocaleKeys.register_password_hint.tr(),
                          labelWidget: Text(
                            LocaleKeys.register_password_label.tr(),
                          ),
                          autovalidateMode: AutovalidateMode.disabled,
                          maxLine: 1,
                          errorMaxLines: 3,
                          isObscureText: state.isObscure,
                          suffixWidget: GestureDetector(
                            onTap: () {
                              cubit.doIntent(TogglePasswordObscureEvent());
                            },
                            child: Icon(
                              state.isObscure
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: AppColors.gray53,
                            ),
                          ),
                          validator: (value) {
                            return Validations.validatePassword(value);
                          },
                        );
                      },
                    ),
              ),
              Expanded(
                child:
                    BlocSelector<
                      RegisterCubit,
                      RegisterStates,
                      PasswordFieldState
                    >(
                      selector: (state) {
                        return state.confirmPasswordFieldState;
                      },
                      builder: (context, state) {
                        return CustomTextField(
                          controller: cubit.confirmPasswordController,
                          hintText: LocaleKeys.register_confirm_password_hint
                              .tr(),
                          labelWidget: Text(
                            LocaleKeys.register_confirm_password_label.tr(),
                          ),
                          autovalidateMode: AutovalidateMode.disabled,
                          maxLine: 1,
                          isObscureText: state.isObscure,
                          errorMaxLines: 3,
                          errorText: state.error,
                          suffixWidget: GestureDetector(
                            onTap: () {
                              cubit.doIntent(ToggleConfirmPasswordObscureEvent());
                            },
                            child: Icon(
                              state.isObscure
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: AppColors.gray53,
                            ),
                          ),
                          validator: (value) {
                            return Validations.validatePassword(value);
                          },
                        );
                      },
                    ),
              ),
            ],
          ),
          SizedBox(height: formPadding),
          CustomTextField(
            controller: cubit.phoneController,
            hintText: LocaleKeys.register_phone_hint.tr(),
            labelWidget: Text(LocaleKeys.register_phone_label.tr()),
            textInputType: TextInputType.phone,
            autovalidateMode: AutovalidateMode.disabled,
            validator: (value) {
              return Validations.validatePhoneNumber(value, phoneLength, countryCode);
            },
          ),
        ],
      ),
    );
  }
}
