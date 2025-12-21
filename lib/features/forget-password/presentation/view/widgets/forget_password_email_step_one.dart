import 'package:easy_localization/easy_localization.dart';
import 'package:elevate_flower_app/core/languages/locale_keys.g.dart';
import 'package:elevate_flower_app/core/shared/widgets/custom_button.dart';
import 'package:elevate_flower_app/core/shared/widgets/custom_text_field.dart';
import 'package:elevate_flower_app/core/theme/app_colors.dart';
import 'package:elevate_flower_app/core/validations/validations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgetPasswordEmailStepOne extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  const ForgetPasswordEmailStepOne({super.key, required this.formKey});

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
          // controller: viewModel.firstNameController,
          validator: Validations.validateEmail,

          maxLine: 1,
          fillColor: AppColors.transparent,
          hintText: LocaleKeys.forget_password_enter_your_email.tr(),
          labelWidget: Text(LocaleKeys.forget_password_email.tr()),
        ),
        SizedBox(height: 64.h),
        CustomButton(
          onPressed: () {
            if (widget.formKey.currentState!.validate()) {}
          },
          title: LocaleKeys.forget_password_confirm.tr(),
        ),
      ],
    );
  }
}
