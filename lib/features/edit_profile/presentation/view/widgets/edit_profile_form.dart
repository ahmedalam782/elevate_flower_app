import 'package:easy_localization/easy_localization.dart';
import '../../../../../core/languages/locale_keys.g.dart';
import '../../../../../core/shared/widgets/custom_text_field.dart';
import '../../../../../core/validations/validations.dart';
import '../../view_model/cubit/edit_profile_cubit.dart';
import '../../view_model/cubit/edit_profile_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/routes/routes.dart' show Routes;

class EditProfileForm extends StatelessWidget {
  EditProfileForm({super.key});
  final _horizontalSpacing = 24.h;
  static const String _countryCode = '+20';
  static const int _phoneLength = 10;
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<EditProfileCubit>();
    return Form(
      key: cubit.formKey,
      child: Column(
        children: [
          Row(
            spacing: _horizontalSpacing,
            children: [
              Expanded(
                child: CustomTextField(
                  controller: cubit.firstNameController,
                  hintText: LocaleKeys.edit_profile_first_name_label.tr(),
                  labelWidget: Text(
                    LocaleKeys.edit_profile_first_name_label.tr(),
                  ),
                  textInputType: TextInputType.name,
                  autovalidateMode: AutovalidateMode.disabled,
                  validator: (value) => Validations.validateFirstName(value),
                  onChanged: (_) {
                    cubit.onEvent(EditProfileEvents.checkFormChangedEvent());
                  },
                ),
              ),
              Expanded(
                child: CustomTextField(
                  controller: cubit.lastNameController,
                  hintText: LocaleKeys.edit_profile_last_name_label.tr(),
                  labelWidget: Text(
                    LocaleKeys.edit_profile_last_name_label.tr(),
                  ),
                  textInputType: TextInputType.name,
                  autovalidateMode: AutovalidateMode.disabled,
                  validator: (value) => Validations.validateLastName(value),
                  onChanged: (_) {
                    cubit.onEvent(EditProfileEvents.checkFormChangedEvent());
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: _horizontalSpacing),
          CustomTextField(
            controller: cubit.emailController,
            hintText: LocaleKeys.edit_profile_email_label.tr(),
            labelWidget: Text(LocaleKeys.edit_profile_email_label.tr()),
            textInputType: TextInputType.emailAddress,
            autovalidateMode: AutovalidateMode.disabled,
            validator: (value) => Validations.validateEmail(value),
            onChanged: (_) {
              cubit.onEvent(EditProfileEvents.checkFormChangedEvent());
            },
          ),
          SizedBox(height: _horizontalSpacing),
          CustomTextField(
            controller: cubit.phoneNumberController,
            hintText: LocaleKeys.edit_profile_phone_label.tr(),
            labelWidget: Text(LocaleKeys.edit_profile_phone_label.tr()),
            textInputType: TextInputType.phone,
            autovalidateMode: AutovalidateMode.disabled,
            validator: (value) => Validations.validatePhoneNumber(
              value,
              _phoneLength,
              _countryCode,
            ),
            onChanged: (_) {
              cubit.onEvent(EditProfileEvents.checkFormChangedEvent());
            },
          ),
          SizedBox(height: _horizontalSpacing),
          CustomTextField(
            controller: cubit.passwordController,
            isReadOnly: true,
            hintText: LocaleKeys.login_password_label.tr(),
            labelWidget: Text(LocaleKeys.login_password_label.tr()),
            autovalidateMode: AutovalidateMode.disabled,
            isObscureText: true,
            maxLine: 1,
            suffixWidget: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: SizedBox(
                width: 50, // enough space for "Show"
                child: Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      context.push(Routes.resetPassword);
                    },
                    child: Text(
                      LocaleKeys.edit_profile_change.tr(),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
