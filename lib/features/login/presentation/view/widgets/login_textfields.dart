import 'package:easy_localization/easy_localization.dart';
import '../../../../../core/languages/locale_keys.g.dart';
import '../../../../../core/shared/widgets/custom_text_field.dart';
import '../../../../../core/shared/widgets/pass_text_field.dart';
import '../../../../../core/validations/validations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../view_model/cubit/login_cubit.dart';
import '../../view_model/cubit/login_events.dart';

class LoginTextfields extends StatelessWidget {
  const LoginTextfields({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LoginCubit>();

    return Column(
      children: [
        SizedBox(height: 20.h),

        CustomTextField(
          controller: cubit.emailController,
          hintText: LocaleKeys.login_email_hint_text.tr(),
          labelWidget: Text(LocaleKeys.login_email_label.tr()),
          textInputType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          autovalidateMode: AutovalidateMode.disabled,
          validator: (value) {
            return Validations.validateEmail(value);
          },
        ),

        SizedBox(height: 16.h),

        PassTextField(
          controller: cubit.passwordController,
          hintText: LocaleKeys.login_password_hint_text.tr(),
          labelWidget: Text(LocaleKeys.login_password_label.tr()),
          textInputAction: TextInputAction.done,
          autovalidateMode: AutovalidateMode.disabled,
          validator: (value) {
            return Validations.validatePassword(value);
          },
          onFieldSubmitted: (_) {
            FocusScope.of(context).unfocus();
            cubit.doIntent(LoginEvents.loginUserEvent());
          },
        ),
      ],
    );
  }
}
