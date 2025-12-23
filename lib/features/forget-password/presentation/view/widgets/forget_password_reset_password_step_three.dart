import 'package:easy_localization/easy_localization.dart';
import 'package:elevate_flower_app/core/languages/locale_keys.g.dart';
import 'package:elevate_flower_app/core/shared/widgets/custom_button.dart';
import 'package:elevate_flower_app/core/shared/widgets/custom_text_field.dart';
import 'package:elevate_flower_app/core/theme/app_colors.dart';
import 'package:elevate_flower_app/core/validations/validations.dart';
import 'package:elevate_flower_app/features/forget-password/presentation/view_model/cubit/forgetPassword_cubit.dart';
import 'package:elevate_flower_app/features/forget-password/presentation/view_model/cubit/forgetPassword_events.dart';
import 'package:elevate_flower_app/features/forget-password/presentation/view_model/cubit/forgetPassword_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgetPasswordResetPasswordStepThree extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final ForgetpasswordCubit forgetpasswordCubit;

  const ForgetPasswordResetPasswordStepThree({
    super.key,
    required this.formKey,
    required this.forgetpasswordCubit,
  });

  @override
  State<ForgetPasswordResetPasswordStepThree> createState() =>
      _ForgetPasswordResetPasswordStepThreeState();
}

class _ForgetPasswordResetPasswordStepThreeState
    extends State<ForgetPasswordResetPasswordStepThree> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 40.h),
        Align(
          alignment: AlignmentGeometry.center,
          child: Text(
            LocaleKeys.forget_password_rest_password.tr(),
            textAlign: TextAlign.center,

            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
          ),
        ),
        SizedBox(height: 16.h),
        Align(
          alignment: AlignmentGeometry.center,

          child: Text(
            LocaleKeys.forget_password_password_requierment.tr(),
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14.sp, color: AppColors.gray53),
          ),
        ),
        SizedBox(height: 32.h),
        BlocSelector<ForgetpasswordCubit, ForgetpasswordStates, bool>(
          selector: (state) {
            return state.newPasswordVisible;
          },
          builder: (context, state) {
            return CustomTextField(
              controller: widget.forgetpasswordCubit.passwordController,

              isObscureText: !state,
              suffixWidget: InkWell(
                onTap: () {
                  widget.forgetpasswordCubit.doIntent(
                    TogglePasswordEvent(isConfirmPassword: false),
                    context,
                  );
                },
                child: Icon(
                  !state
                      ? Icons.visibility_off_rounded
                      : Icons.visibility_rounded,
                  color: AppColors.primerColor,
                ),
              ),
              // controller: viewModel.firstNameController,
              autovalidateMode: AutovalidateMode.disabled,
              validator: Validations.validatePassword,

              maxLine: 1,
              fillColor: AppColors.transparent,
              hintText: LocaleKeys.forget_password_enter_your_password.tr(),
              labelWidget: Text(LocaleKeys.forget_password_new_password.tr()),
            );
          },
        ),
        SizedBox(height: 24.h),

        BlocSelector<ForgetpasswordCubit, ForgetpasswordStates, bool>(
          selector: (state) {
            return state.confirmPasswordVisible;
          },
          builder: (context, state) {
            return CustomTextField(
              controller: widget.forgetpasswordCubit.confirmPasswordController,
              isObscureText: !state,
              suffixWidget: InkWell(
                onTap: () {
                  widget.forgetpasswordCubit.doIntent(
                    TogglePasswordEvent(isConfirmPassword: true),
                    context,
                  );
                },
                child: Icon(
                  !state
                      ? Icons.visibility_off_rounded
                      : Icons.visibility_rounded,
                  color: AppColors.primerColor,
                ),
              ),

              // controller: viewModel.firstNameController,
              autovalidateMode: AutovalidateMode.disabled,

              validator: (value) {
                return Validations.validatePasswordVerification(
                  value,
                  widget.forgetpasswordCubit.passwordController.text,
                );
              },

              maxLine: 1,
              fillColor: AppColors.transparent,
              hintText: LocaleKeys.forget_password_confirm_password.tr(),
              labelWidget: Text(
                LocaleKeys.forget_password_confirm_password.tr(),
              ),
            );
          },
        ),
        SizedBox(height: 64.h),
        CustomButton(
          onPressed: () {
            if (widget.formKey.currentState!.validate()) {
              widget.forgetpasswordCubit.doIntent(
                ResetPasswordEvent(),
                context,
              );
            }
          },
          title: LocaleKeys.forget_password_confirm.tr(),
        ),
      ],
    );
  }
}
