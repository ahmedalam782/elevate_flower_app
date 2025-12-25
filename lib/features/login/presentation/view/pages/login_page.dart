import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';
import '../../../../../core/config/base_state/base_state.dart';
import '../../../../../core/config/di/injectable_config.dart';
import '../../../../../core/routes/routes.dart';
import '../../../../../core/shared/widgets/custom_button.dart';
import '../../../../../core/shared/widgets/custom_text_field.dart';
import '../../../../../core/shared/widgets/custom_toast.dart';
import '../../../../../core/shared/widgets/pass_text_field.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_icons.dart';
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
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: Form(
            key: cubit.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40.h),

                Text(
                  'Login',
                  style: 32.bold.copyWith(color: AppColors.primerColor),
                ),
                SizedBox(height: 8.h),

                Text(
                  'Welcome back! Please login to continue',
                  style: 14.regular.copyWith(color: AppColors.grayA6),
                ),
                SizedBox(height: 40.h),

                CustomTextField(
                  controller: cubit.emailController,
                  hintText: 'Enter your email',
                  labelText: 'Email',
                  title: 'Email',
                  prefixIcon: AppIcons.iconsLock,
                  textInputType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: Validations.validateEmail,
                ),
                SizedBox(height: 16.h),

                PassTextField(
                  controller: cubit.passwordController,
                  hintText: 'Enter your password',
                  labelText: 'Password',
                  title: 'Password',
                  textInputAction: TextInputAction.done,
                  isErrorEnabled: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'validations.password_required'.tr();
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                  onFieldSubmitted: (_) => _handleLogin(context),
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
                          activeColor: AppColors.primerColor,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          visualDensity: VisualDensity.compact,
                        ),
                        Text(
                          'Remember me',
                          style: 14.regular.copyWith(color: AppColors.grayA6),
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
                        'Forgot password?',
                        style: 14.regular.copyWith(
                          color: AppColors.primerColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 32.h),

                BlocConsumer<LoginCubit, LoginStates>(
                  listener: (context, states) {
                    states.loginState.when(
                      initial: () {},
                      loading: () {},
                      success: (loginResponse) {
                        CustomToast(
                          context: context,
                          header: 'Success',
                          description:
                              'Welcome ${loginResponse.user.firstName} ${loginResponse.user.lastName}!',
                          type: ToastificationType.success,
                        ).showToast();

                        Future.delayed(const Duration(seconds: 1), () {
                          if (context.mounted) {
                            context.go(Routes.home);
                          }
                        });
                      },
                      error: (exception) {
                        CustomToast(
                          context: context,
                          header: 'Error',
                          description: exception.toString(),
                          type: ToastificationType.error,
                        ).showToast();
                      },
                    );
                  },
                  builder: (context, states) {
                    final isLoading =
                        states.loginState.state == StateType.loading;

                    return CustomButton(
                      title: 'Login',
                      onPressed: isLoading ? null : () => _handleLogin(context),
                      isLoading: isLoading,
                      isGradient: true,
                      gradient: AppColors.primerGradient,
                    );
                  },
                ),
                SizedBox(height: 24.h),

                CustomButton(
                  title: 'Continue as guest',
                  onPressed: () {
                    context.go(Routes.home);
                  },
                  isFilled: false,
                  borderColor: AppColors.primerColor,
                  backGroundColor: AppColors.black,
                ),
                SizedBox(height: 24.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: 14.regular.copyWith(color: AppColors.grayA6),
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
                        'Sign up',
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