import 'package:easy_localization/easy_localization.dart';
import 'package:elevate_flower_app/core/languages/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';
import '../../../../../core/config/base_state/base_state.dart';
import '../../../../../core/config/di/injectable_config.dart';
import '../../../../../core/routes/routes.dart';
import '../../../../../core/shared/widgets/custom_app_bar.dart';
import '../../../../../core/shared/widgets/custom_button.dart';
import '../../../../../core/shared/widgets/custom_text_field.dart';
import '../../../../../core/shared/widgets/custom_toast.dart';
import '../../../../../core/shared/widgets/pass_text_field.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_typography.dart';
import '../../../../../core/validations/validations.dart';
import '../../view_model/cubit/login_cubit.dart';
import '../../view_model/cubit/login_events.dart';
import '../../view_model/cubit/login_states.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<LoginCubit>(),
      child: const LoginView(),
    );
  }
}

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
                SizedBox(height: 20.h),

                CustomTextField(
                  controller: cubit.emailController,
                  hintText: LocaleKeys.login_email_hint_text.tr(),
                  labelText: LocaleKeys.login_email_label.tr(),
                  textInputType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: Validations.validateEmail,
                ),
                SizedBox(height: 16.h),

                PassTextField(
                  controller: cubit.passwordController,
                  hintText: LocaleKeys.login_password_hint_text.tr(),
                  labelText: LocaleKeys.login_password_label.tr(),
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => _handleLogin(context),
                  validator: Validations.validatePassword,
                ),
                SizedBox(height: 8.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: cubit.isRememberMe,
                          onChanged: (value) {
                            setState(() {
                              cubit.isRememberMe = value ?? false;
                            });
                          },
                          checkColor: AppColors.whiteF9,
                          activeColor: AppColors.primerColor,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          visualDensity: VisualDensity.compact,
                        ),
                        Text(
                          LocaleKeys.login_remember_me.tr(),
                          style: 14.regular,
                        ),
                      ],
                    ),

                    TextButton(
                      onPressed: () {
                        context.push(Routes.forgetPassword);
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        LocaleKeys.login_forgot_password.tr(),
                        style: 14.regular.copyWith(color: AppColors.black0C),
                      ),
                    ),
                  ],
                ),
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
                      error: (exception) {
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
                      onPressed: isLoading ? null : () => _handleLogin(context),
                      isLoading: isLoading,
                    );
                  },
                ),
                SizedBox(height: 24.h),

                CustomButton(
                  title: LocaleKeys.login_continue_as_guest.tr(),
                  onPressed: () {
                    context.go(Routes.appLayout);
                  },
                  isFilled: false,
                  borderColor: AppColors.grayA6,
                  backGroundColor: AppColors.gray53,
                ),
                SizedBox(height: 24.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      LocaleKeys.login_no_account.tr(),
                      style: 14.regular.copyWith(color: AppColors.black0C),
                    ),
                    TextButton(
                      onPressed: () {
                        context.push(Routes.register);
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        LocaleKeys.login_sign_up.tr(),
                        style: 14.semiBold.copyWith(
                          color: AppColors.primerColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleLogin(BuildContext context) {
    final cubit = context.read<LoginCubit>();

    if (cubit.formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();

      cubit.doIntent(LoginEvents.loginUserEvent());
    }
  }
}
