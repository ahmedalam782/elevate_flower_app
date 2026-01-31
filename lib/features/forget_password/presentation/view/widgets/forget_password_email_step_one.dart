import 'package:easy_localization/easy_localization.dart';
import '../../../../../core/languages/locale_keys.g.dart';
import '../../../../../core/shared/widgets/custom_button.dart';
import '../../../../../core/shared/widgets/custom_text_field.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/validations/validations.dart';
import '../../view_model/cubit/forget_password_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../view_model/cubit/forget_password_events.dart';

class ForgetPasswordEmailStepOne extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final ForgetPasswordCubit forgetPasswordCubit;
  const ForgetPasswordEmailStepOne({
    super.key,
    required this.formKey,
    required this.forgetPasswordCubit,
  });

  @override
  State<ForgetPasswordEmailStepOne> createState() =>
      _ForgetPasswordEmailStepOneState();
}

class _ForgetPasswordEmailStepOneState
    extends State<ForgetPasswordEmailStepOne> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 40.h),
        Align(
          alignment: AlignmentGeometry.center,
          child: Text(
            LocaleKeys.forget_password_forget_password.tr(),
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
          ),
        ),
        SizedBox(height: 16.h),
        Align(
          alignment: AlignmentGeometry.center,

          child: Text(
            LocaleKeys.forget_password_please_enter_your_email.tr(),
            style: TextStyle(fontSize: 14.sp, color: AppColors.gray53),
          ),
        ),
        SizedBox(height: 32.h),
        CustomTextField(
          controller: widget.forgetPasswordCubit.emailController,
          validator: Validations.validateEmail,

          maxLine: 1,
          fillColor: AppColors.transparent,
          hintText: LocaleKeys.forget_password_enter_your_email.tr(),
          labelWidget: Text(LocaleKeys.forget_password_email.tr()),
        ),
        SizedBox(height: 64.h),
        CustomButton(
          onPressed: () {
            if (widget.formKey.currentState!.validate()) {
              widget.forgetPasswordCubit.doIntent(
                SendOtpToEmailEvent(),
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
