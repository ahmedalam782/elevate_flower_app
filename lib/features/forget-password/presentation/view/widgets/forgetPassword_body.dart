// TODO: presentation ForgetPasswordBody

import 'package:easy_localization/easy_localization.dart';
import 'package:elevate_flower_app/core/config/base_state/base_state.dart';
import 'package:elevate_flower_app/core/config/di/injectable_config.dart';
import 'package:elevate_flower_app/core/errors/failures.dart';
import 'package:elevate_flower_app/core/languages/locale_keys.g.dart';
import 'package:elevate_flower_app/core/shared/widgets/custom_button.dart';
import 'package:elevate_flower_app/core/shared/widgets/custom_text_field.dart';
import 'package:elevate_flower_app/core/shared/widgets/custom_toast.dart';
import 'package:elevate_flower_app/core/theme/app_colors.dart';
import 'package:elevate_flower_app/core/validations/validations.dart';
import 'package:elevate_flower_app/features/forget-password/presentation/view/widgets/forget_password_email_step_one.dart';
import 'package:elevate_flower_app/features/forget-password/presentation/view/widgets/forget_password_otp_step_two.dart';
import 'package:elevate_flower_app/features/forget-password/presentation/view/widgets/forget_password_reset_password_step_three.dart';
import 'package:elevate_flower_app/features/forget-password/presentation/view_model/cubit/forgetPassword_cubit.dart';
import 'package:elevate_flower_app/features/forget-password/presentation/view_model/cubit/forgetPassword_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';

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
        child: BlocListener<ForgetpasswordCubit, ForgetpasswordStates>(
          listener: (context, state) {
            if (state.state == StateType.error) {
              print("ERROR STATE");
              final exe = state.exception;
              if (exe is Failures) {
                CustomToast(
                  context: context,
                  description: exe.errorMessage,

                  // header: ,
                  type: ToastificationType.error,
                ).showAlertToast(
                  // mainColor: Colors.red,
                  backgroundColor: AppColors.redCC,
                  message: exe.errorMessage,
                  mainColor: Colors.white,
                );
              }
            }
            if (state.isPasswordReset == true) {
              print("SUCCESSS");
              if (context.canPop()) {
                context.pop();
              }
            }
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: SafeArea(
              child: PageView.builder(
                itemCount: 3,
                physics: const NeverScrollableScrollPhysics(),
                controller: viewModel.pageController,
                itemBuilder: (context, index) {
                  switch (index) {
                    case 0:
                      return ForgetPasswordEmailStepOne(
                        formKey: _formKey,
                        forgetpasswordCubit: viewModel,
                      );
                    case 1:
                      return ForgetPasswordOtpStepTwo(
                        forgetpasswordCubit: viewModel,
                      );
                    case 2:
                      return ForgetPasswordResetPasswordStepThree(
                        formKey: _formKey,
                        forgetpasswordCubit: viewModel,
                      );
                  }
                  return SizedBox.shrink();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
