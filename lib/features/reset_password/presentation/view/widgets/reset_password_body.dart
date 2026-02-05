import 'package:easy_localization/easy_localization.dart';
import '../../../../../core/config/base_state/base_state.dart';
import '../../../../../core/languages/locale_keys.g.dart';
import '../../../../../core/shared/widgets/custom_button.dart';
import '../../view_model/cubit/reset_password_cubit.dart';
import '../../view_model/cubit/reset_password_events.dart';
import '../../view_model/cubit/reset_password_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'reset_password_bloc_listener.dart';
import 'reset_password_form.dart';

class ResetPasswordBody extends StatelessWidget {
  const ResetPasswordBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ResetPasswordCubit>();
    return Column(
      children: [
        const ResetPasswordForm(),
        const SizedBox(height: 50.0),
        BlocBuilder<ResetPasswordCubit, ResetPasswordStates>(
          builder: (context, state) {
            return CustomButton(
              title: LocaleKeys.reset_password_update_button.tr(),
              isLoading: state.changePasswordState.state == StateType.loading,
              onPressed: () {
                if (cubit.formKey.currentState!.validate()) {
                  cubit.doIntent(
                    ResetPasswordEvents.changePassword(
                      currentPassword: cubit.currentPasswordController.text,
                      newPassword: cubit.newPasswordController.text,
                      confirmPassword: cubit.confirmPasswordController.text,
                    ),
                  );
                }
              },
              borderColor: Colors.transparent,
            );
          },
        ),
        const ResetPasswordBlocListener(),
      ],
    );
  }
}