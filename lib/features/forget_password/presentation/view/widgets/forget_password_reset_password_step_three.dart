import 'package:easy_localization/easy_localization.dart';
import '../../../../../core/languages/locale_keys.g.dart';
import '../../../../../core/shared/widgets/custom_button.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/validations/validations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/shared/widgets/pass_text_field.dart';
import '../../view_model/cubit/forget_password_events.dart';
import '../../view_model/cubit/forget_password_states.dart';
import '../../view_model/cubit/forget_password_cubit.dart';

class ForgetPasswordResetPasswordStepThree extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final ForgetPasswordCubit forgetPasswordCubit;

  const ForgetPasswordResetPasswordStepThree({
    super.key,
    required this.formKey,
    required this.forgetPasswordCubit,
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
        BlocSelector<ForgetPasswordCubit, ForgetPasswordStates, bool>(
          selector: (state) {
            return state.newPasswordVisible;
          },
          builder: (context, state) {
            return PassTextField(
              controller: widget.forgetPasswordCubit.passwordController,
              autovalidateMode: AutovalidateMode.disabled,
              validator: Validations.validatePassword,
              fillColor: AppColors.transparent,
              hintText: LocaleKeys.forget_password_enter_your_password.tr(),
              labelWidget: Text(LocaleKeys.forget_password_new_password.tr()),
            );
          },
        ),
        SizedBox(height: 24.h),

        BlocSelector<ForgetPasswordCubit, ForgetPasswordStates, bool>(
          selector: (state) {
            return state.confirmPasswordVisible;
          },
          builder: (context, state) {
            return PassTextField(
              controller: widget.forgetPasswordCubit.confirmPasswordController,
              autovalidateMode: AutovalidateMode.disabled,

              validator: (value) {
                return Validations.validatePasswordVerification(
                  value,
                  widget.forgetPasswordCubit.passwordController.text,
                );
              },
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
              widget.forgetPasswordCubit.doIntent(
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
