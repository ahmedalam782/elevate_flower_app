import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';

import '../../../../../core/config/base_state/base_state.dart';
import '../../../../../core/errors/failures.dart';
import '../../../../../core/languages/locale_keys.g.dart';
import '../../../../../core/shared/widgets/custom_toast.dart';
import '../../view_model/cubit/forget_password_cubit.dart';
import '../../view_model/cubit/forget_password_states.dart';
import 'forget_password_email_step_one.dart';
import 'forget_password_otp_step_two.dart';
import 'forget_password_reset_password_step_three.dart';

class ForgetPasswordBody extends StatefulWidget {
  const ForgetPasswordBody({super.key, required this.viewModel});
  final ForgetPasswordCubit viewModel;

  @override
  State<ForgetPasswordBody> createState() => _ForgetPasswordBodyState();
}

class _ForgetPasswordBodyState extends State<ForgetPasswordBody> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: BlocListener<ForgetPasswordCubit, ForgetPasswordStates>(
        listener: (context, state) {
          if (state.state == StateType.error) {
            log("ERROR STATE");
            final exe = state.exception;
            if (exe is Failures) {
              CustomToast(
                context: context,
                header: exe.errorMessage,

                // header: ,
                type: ToastificationType.error,
              ).showToast();
            }
          }
          if (state.isPasswordReset == true) {
            CustomToast(
              context: context,
              header: LocaleKeys.forget_password_password_rest_successfully
                  .tr(),

              // header: ,
              type: ToastificationType.success,
            ).showToast();
            log("SUCCESSS");
            if (context.canPop()) {
              context.pop(true);
            }
          }
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: SafeArea(
            child: PageView.builder(
              itemCount: 3,
              physics: const NeverScrollableScrollPhysics(),
              controller: widget.viewModel.pageController,
              itemBuilder: (context, index) {
                switch (index) {
                  case 0:
                    return ForgetPasswordEmailStepOne(
                      formKey: _formKey,
                      forgetPasswordCubit: widget.viewModel,
                    );
                  case 1:
                    return ForgetPasswordOtpStepTwo(
                      forgetPasswordCubit: widget.viewModel,
                    );
                  case 2:
                    return ForgetPasswordResetPasswordStepThree(
                      formKey: _formKey,
                      forgetPasswordCubit: widget.viewModel,
                    );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      ),
    );
  }
}
