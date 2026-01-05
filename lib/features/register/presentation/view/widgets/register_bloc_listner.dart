import 'package:elevate_flower_app/core/errors/handle_errors/handle_errors.dart';
import 'package:elevate_flower_app/core/routes/routes.dart';
import 'package:elevate_flower_app/core/shared/widgets/custom_toast.dart';
import 'package:elevate_flower_app/features/register/presentation/view_model/cubit/register_cubit.dart';
import 'package:elevate_flower_app/features/register/presentation/view_model/cubit/register_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';

class RegisterBlocListener extends StatelessWidget {
  const RegisterBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterStates>(
      listenWhen: (previous, current) {
        return previous.registerState != current.registerState;
      },
      listener: (context, state) {
        state.registerState.when(
          initial: () {},
          loading: () {},
          success: (data) {
            CustomToast(
              context: context,
              header: data.message,
              type: ToastificationType.success,
            ).showToast();
            context.go(Routes.login);
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
