import 'package:elevate_flower_app/features/edit_profile/presentation/view_model/cubit/edit_profile_cubit.dart';
import 'package:elevate_flower_app/features/edit_profile/presentation/view_model/cubit/edit_profile_events.dart';
import 'package:elevate_flower_app/features/edit_profile/presentation/view_model/cubit/edit_profile_states.dart';
import 'package:elevate_flower_app/features/register/presentation/view/widgets/gender_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserDetailGenderBuilder extends StatelessWidget {
  const UserDetailGenderBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<EditProfileCubit>();
    return BlocBuilder<EditProfileCubit, EditProfileStates>(
      buildWhen: (previous, current) {
        return previous.genderRowState != current.genderRowState;
      },
      builder: (context, state) {
        return GenderRow(
          selectedGender: state.genderRowState?.selectedGender,
          showError: state.genderRowState?.showGenderError ?? false,
          onChanged: (gender) {
            cubit.onEvent(EditProfileEvents.onGenderSelectedEvent(gender));
            cubit.onEvent(EditProfileEvents.checkFormChangedEvent());
          },
        );
      },
    );
  }
}
