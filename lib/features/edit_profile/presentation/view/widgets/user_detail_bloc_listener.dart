import 'package:easy_localization/easy_localization.dart';
import 'package:elevate_flower_app/core/languages/locale_keys.g.dart';
import 'package:elevate_flower_app/core/shared/widgets/custom_toast.dart';
import 'package:elevate_flower_app/features/edit_profile/domain/entities/edit_profile_result.dart';
import 'package:elevate_flower_app/features/edit_profile/presentation/view_model/cubit/edit_profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';

class UserDetailBlocListener extends StatelessWidget {
  const UserDetailBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<EditProfileCubit>();
    return StreamBuilder<EditProfileResult>(
      stream: cubit.updateResultStream,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            final result = snapshot.data!;
            CustomToast(
              context: context,
              header: result.success
                  ? LocaleKeys.edit_profile_profile_updated_successfully.tr()
                  : result.message,
              type: result.success
                  ? ToastificationType.success
                  : ToastificationType.error,
            ).showToast();
            if (result.success) Navigator.pop(context);
          });
        }
        return const SizedBox.shrink();
      },
    );
  }
}
