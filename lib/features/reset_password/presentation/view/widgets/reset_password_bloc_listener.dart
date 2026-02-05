import '../../../../../core/config/api/end_points.dart';
import '../../../../../core/config/di/injectable_config.dart';
import '../../../../../core/errors/handle_errors/handle_errors.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../../../core/shared/widgets/custom_toast.dart';
import '../../view_model/cubit/reset_password_cubit.dart';
import '../../view_model/cubit/reset_password_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';

class ResetPasswordBlocListener extends StatelessWidget {
  const ResetPasswordBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ResetPasswordCubit, ResetPasswordStates>(
      listenWhen: (previous, current) {
        return previous.changePasswordState != current.changePasswordState;
      },
      listener: (context, state) {
        state.changePasswordState.when(
          initial: () {},
          loading: () {},
          success: (data) async {
            if (context.mounted) {
              CustomToast(
                context: context,
                header: data.message,
                type: ToastificationType.success,
              ).showToast();
            }

            if (data.token != null) {
              final secureStorage = getIt<FlutterSecureStorage>();
              await secureStorage.write(
                key: Apikeys.accessToken,
                value: data.token,
              );
            }
            if (context.mounted) {
              context.pop();
            }
          },
          error: (exception) {
            CustomToast(
              context: context,
              header: handleError(exception),
              type: ToastificationType.error,
            ).showToast();
          },
        );
      },
      child: const SizedBox.shrink(),
    );
  }
}
