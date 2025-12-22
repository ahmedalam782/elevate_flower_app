// TODO: presentation ForgetPasswordBody

import 'package:easy_localization/easy_localization.dart';
import 'package:elevate_flower_app/core/config/di/injectable_config.dart';
import 'package:elevate_flower_app/core/languages/locale_keys.g.dart';
import 'package:elevate_flower_app/core/shared/widgets/custom_button.dart';
import 'package:elevate_flower_app/core/shared/widgets/custom_text_field.dart';
import 'package:elevate_flower_app/core/theme/app_colors.dart';
import 'package:elevate_flower_app/core/validations/validations.dart';
import 'package:elevate_flower_app/features/forget-password/presentation/view/widgets/forget_password_email_step_one.dart';
import 'package:elevate_flower_app/features/forget-password/presentation/view/widgets/forget_password_otp_step_two.dart';
import 'package:elevate_flower_app/features/forget-password/presentation/view/widgets/forget_password_reset_password_step_three.dart';
import 'package:elevate_flower_app/features/forget-password/presentation/view_model/cubit/forgetPassword_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgetPasswordBody extends StatefulWidget {
  const ForgetPasswordBody({super.key});

  @override
  State<ForgetPasswordBody> createState() => _ForgetPasswordBodyState();
}

class _ForgetPasswordBodyState extends State<ForgetPasswordBody> {
  late ForgetpasswordCubit viewModel;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    viewModel = getIt<ForgetpasswordCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => viewModel,
      child: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: SafeArea(
            child: PageView.builder(
              itemCount: 3,
              // physics: NeverScrollableScrollPhysics(),
              controller: viewModel.pageController,
              itemBuilder: (context, index) {
                switch (index) {
                  case 0:
                    return ForgetPasswordEmailStepOne(
                      formKey: _formKey,
                      forgetpasswordCubit: viewModel,
                    );
                  case 1:
                    return ForgetPasswordOtpStepTwo();
                  case 2:
                    return ForgetPasswordResetPasswordStepThree(
                      formKey: _formKey,
                    );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
