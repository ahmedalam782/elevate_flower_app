import 'package:easy_localization/easy_localization.dart';
import 'package:elevate_flower_app/core/languages/locale_keys.g.dart';
import 'package:elevate_flower_app/core/shared/widgets/pass_text_field.dart';
import 'package:elevate_flower_app/core/validations/validations.dart';
import 'package:elevate_flower_app/features/reset_password/presentation/view_model/cubit/reset_password_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class ResetPasswordForm extends StatelessWidget {
  const ResetPasswordForm({super.key});
  
  static const double formPadding = 24.0;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ResetPasswordCubit>();
    
    return Form(
      key: cubit.formKey,
      child: Column(
        children: [
          // Current Password Field
          PassTextField(
            controller: cubit.currentPasswordController,
            hintText: LocaleKeys.reset_password_current_password.tr(),
            labelText: LocaleKeys.reset_password_current_password.tr(),
            autovalidateMode: AutovalidateMode.disabled,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'validations.password_required'.tr();
              }
              return null;
            },
          ),
          const SizedBox(height: formPadding),
          
          // New Password Field
          PassTextField(
            controller: cubit.newPasswordController,
            hintText: LocaleKeys.reset_password_new_password.tr(),
            labelText: LocaleKeys.reset_password_new_password.tr(),
            autovalidateMode: AutovalidateMode.disabled,
            validator: (value) {
              return Validations.validatePassword(value);
            },
          ),
          const SizedBox(height: formPadding),
          
          // Confirm Password Field
          PassTextField(
            controller: cubit.confirmPasswordController,
            hintText: LocaleKeys.reset_password_confirm_password.tr(),
            labelText: LocaleKeys.reset_password_confirm_password.tr(),
            autovalidateMode: AutovalidateMode.disabled,
            validator: (value) {
              return Validations.validatePasswordVerification(
                value,
                cubit.newPasswordController.text,
              );
            },
          ),
        ],
      ),
    );
  }
}