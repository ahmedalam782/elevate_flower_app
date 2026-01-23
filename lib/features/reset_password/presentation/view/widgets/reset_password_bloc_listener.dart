import 'package:elevate_flower_app/core/config/api/end_points.dart';
import 'package:elevate_flower_app/core/config/di/injectable_config.dart';
import 'package:elevate_flower_app/core/errors/handle_errors/handle_errors.dart';
import 'package:elevate_flower_app/core/shared/widgets/custom_toast.dart';
import 'package:elevate_flower_app/features/reset_password/presentation/view_model/cubit/reset_password_cubit.dart';
import 'package:elevate_flower_app/features/reset_password/presentation/view_model/cubit/reset_password_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:toastification/toastification.dart';

class ResetPasswordBlocListener extends StatelessWidget {
  const ResetPasswordBlocListener({super.key});

  Future<void> _handleLogout(BuildContext context) async {
    final secureStorage = getIt<FlutterSecureStorage>();
    
    await secureStorage.deleteAll();
    
    if (context.mounted) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        EndPoints.login,
        (route) => false,
      );
    }
  }

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
          success: (data) {
            if (data != null) {
              CustomToast(
                context: context,
                header: data.message,
                type: ToastificationType.success,
              ).showToast();
              
              Future.delayed(const Duration(seconds: 1), () {
                _handleLogout(context);
              });
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