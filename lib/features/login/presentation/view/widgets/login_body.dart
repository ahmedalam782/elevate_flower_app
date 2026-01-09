import 'package:easy_localization/easy_localization.dart';
import 'package:elevate_flower_app/core/languages/locale_keys.g.dart';
import 'package:elevate_flower_app/features/login/presentation/view/widgets/continue_as_guest_buttom.dart';
import 'package:elevate_flower_app/features/login/presentation/view/widgets/do_not_have_account.dart';
import 'package:elevate_flower_app/features/login/presentation/view/widgets/login_options_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';

import '../../../../../core/config/base_state/base_state.dart';
import '../../../../../core/routes/routes.dart';
import '../../../../../core/shared/widgets/custom_app_bar.dart';
import '../../../../../core/shared/widgets/custom_button.dart';
import '../../../../../core/shared/widgets/custom_toast.dart';
import '../../view_model/cubit/login_cubit.dart';
import '../../view_model/cubit/login_events.dart';
import '../../view_model/cubit/login_states.dart';
import 'login_textfields.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({super.key});

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LoginCubit>();

    return Scaffold(
      appBar: CustomAppBar(title: LocaleKeys.login_title.tr()),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: Form(
            key: cubit.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const LoginTextfields(),
                SizedBox(height: 8.h),

                const LoginOptionsRow(),
                SizedBox(height: 50.h),

                BlocConsumer<LoginCubit, LoginStates>(
                  listener: (context, states) {
                    states.loginState.when(
                      initial: () {},
                      loading: () {},
                      success: (loginResponse) {
                        CustomToast(
                          context: context,
                          header: LocaleKeys.global_success.tr(),
                          description: LocaleKeys.login_welcome_message.tr(
                            namedArgs: {
                              'name':
                                  '${loginResponse.user.firstName} ${loginResponse.user.lastName}',
                            },
                          ),
                          type: ToastificationType.success,
                        ).showToast();

                        context.go(Routes.appLayout);
                      },
                      error: (_) {
                        CustomToast(
                          context: context,
                          header: LocaleKeys.global_error.tr(),
                          description: LocaleKeys
                              .login_Invalid_email_or_password
                              .tr(),
                          type: ToastificationType.error,
                        ).showToast();
                      },
                    );
                  },
                  builder: (context, states) {
                    final isLoading =
                        states.loginState.state == StateType.loading;

                    return CustomButton(
                      title: LocaleKeys.login_login_button.tr(),
                      isLoading: isLoading,
                      onPressed: isLoading
                          ? null
                          : () {
                              FocusScope.of(context).unfocus();
                              cubit.doIntent(LoginEvents.loginUserEvent());
                            },
                    );
                  },
                ),
                SizedBox(height: 24.h),

                const ContinueAsGuestButtom(),
                SizedBox(height: 24.h),

                const DoNotHaveAccount(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
