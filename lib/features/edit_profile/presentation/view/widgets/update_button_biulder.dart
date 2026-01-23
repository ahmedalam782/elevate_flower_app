import 'package:easy_localization/easy_localization.dart';
import 'package:elevate_flower_app/core/config/base_state/base_state.dart';
import 'package:elevate_flower_app/core/languages/locale_keys.g.dart';
import 'package:elevate_flower_app/core/shared/widgets/custom_button.dart';
import 'package:elevate_flower_app/features/edit_profile/presentation/view_model/cubit/edit_profile_cubit.dart';
import 'package:elevate_flower_app/features/edit_profile/presentation/view_model/cubit/edit_profile_events.dart';
import 'package:elevate_flower_app/features/edit_profile/presentation/view_model/cubit/edit_profile_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateButtonBiulder extends StatelessWidget {
  const UpdateButtonBiulder({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<EditProfileCubit>();
    return BlocBuilder<EditProfileCubit, EditProfileStates>(
      buildWhen: (previous, current) =>
          previous.isFormChanged != current.isFormChanged ||
          previous.editProfileState?.state != current.editProfileState?.state ||
          previous.updatePhotoState?.state != current.updatePhotoState?.state,
      builder: (context, state) {
        final formState = state.isFormChanged;
        return CustomButton(
          title: LocaleKeys.edit_profile_update_button.tr(),
          borderColor: Colors.transparent,
          isLoading:
              state.editProfileState?.state == StateType.loading ||
              state.updatePhotoState?.state == StateType.loading,
          onPressed: formState
              ? () {
                  cubit.onEvent(EditProfileEvents.onUpdateEvent());
                }
              : null,
        );
      },
    );
  }
}
