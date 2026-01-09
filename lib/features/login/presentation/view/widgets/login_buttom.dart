import 'package:easy_localization/easy_localization.dart';
import 'package:elevate_flower_app/core/config/base_state/base_state.dart';
import 'package:elevate_flower_app/core/languages/locale_keys.g.dart';
import 'package:elevate_flower_app/core/routes/routes.dart';
import 'package:elevate_flower_app/core/shared/widgets/custom_button.dart';
import 'package:elevate_flower_app/core/shared/widgets/custom_toast.dart';
import 'package:elevate_flower_app/features/login/presentation/view_model/cubit/login_cubit.dart';
import 'package:elevate_flower_app/features/login/presentation/view_model/cubit/login_events.dart';
import 'package:elevate_flower_app/features/login/presentation/view_model/cubit/login_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';

class LoginButtom extends StatefulWidget {
  const LoginButtom({super.key});

  @override
  State<LoginButtom> createState() => _LoginButtomState();
}

class _LoginButtomState extends State<LoginButtom> {
  get cubit => null;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
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
              description: LocaleKeys.login_Invalid_email_or_password.tr(),
              type: ToastificationType.error,
            ).showToast();
          },
        );
      },
      builder: (context, states) {
        final isLoading = states.loginState.state == StateType.loading;

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
    );
  }
}
