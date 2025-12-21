import 'package:easy_localization/easy_localization.dart';
import 'package:elevate_flower_app/core/languages/locale_keys.g.dart';
import 'package:elevate_flower_app/core/shared/widgets/custom_app_bar.dart';
import 'package:elevate_flower_app/core/theme/app_colors.dart';
import 'package:elevate_flower_app/features/forget-password/presentation/view/widgets/forgetPassword_body.dart';
import 'package:flutter/material.dart';

class ForgetPasswordPage extends StatelessWidget {
  const ForgetPasswordPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteF9,
      appBar: CustomAppBar(title: LocaleKeys.forget_password_password.tr()),

      body: ForgetPasswordBody(),
    );
  }
}
