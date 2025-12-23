import 'package:easy_localization/easy_localization.dart';
import 'package:elevate_flower_app/core/languages/locale_keys.g.dart';
import 'package:elevate_flower_app/core/shared/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            spacing: 16.0,
            children: [
              Expanded(
                child: CustomTextField(
                  hintText: LocaleKeys.register_first_name_hint.tr(),
                  labelWidget: Text(LocaleKeys.register_first_name_label.tr()),
                  textInputType: TextInputType.name,
                  autovalidateMode: AutovalidateMode.disabled,
                ),
              ),
              Expanded(
                child: CustomTextField(
                  hintText: LocaleKeys.register_last_name_hint.tr(),
                  labelWidget: Text(LocaleKeys.register_last_name_label.tr()),
                  textInputType: TextInputType.name,
                  autovalidateMode: AutovalidateMode.disabled,
                ),
              ),
            ],
          ),
          SizedBox(height: 24.0),
          CustomTextField(
            hintText: LocaleKeys.register_email_hint.tr(),
            labelWidget: Text(LocaleKeys.register_email_label.tr()),
            textInputType: TextInputType.emailAddress,
            autovalidateMode: AutovalidateMode.disabled,
          ),
          SizedBox(height: 24.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            spacing: 16.0,
            children: [
              Expanded(
                child: CustomTextField(
                  hintText: LocaleKeys.register_password_hint.tr(),
                  labelWidget: Text(LocaleKeys.register_password_label.tr()),
                  autovalidateMode: AutovalidateMode.disabled,
                  maxLine: 1,
                  isObscureText: true,
                ),
              ),
              Expanded(
                child: CustomTextField(
                  hintText: LocaleKeys.register_confirm_password_hint.tr(),
                  labelWidget: Text(
                    LocaleKeys.register_confirm_password_label.tr(),
                  ),
                  autovalidateMode: AutovalidateMode.disabled,
                  maxLine: 1,
                  isObscureText: true,
                ),
              ),
            ],
          ),
          SizedBox(height: 24.0),
          CustomTextField(
            hintText: LocaleKeys.register_phone_hint.tr(),
            labelWidget: Text(LocaleKeys.register_phone_label.tr()),
            textInputType: TextInputType.phone,
            autovalidateMode: AutovalidateMode.disabled,
          ),
        ],
      ),
    );
  }
}
