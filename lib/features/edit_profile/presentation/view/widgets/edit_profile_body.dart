import 'package:elevate_flower_app/core/errors/handle_errors/handle_errors.dart';
import 'package:elevate_flower_app/features/edit_profile/presentation/view/widgets/user_details_column.dart';
import 'package:elevate_flower_app/features/edit_profile/presentation/view_model/cubit/edit_profile_cubit.dart';
import 'package:elevate_flower_app/features/edit_profile/presentation/view_model/cubit/edit_profile_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileBody extends StatelessWidget {
  const EditProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditProfileCubit, EditProfileStates>(
      buildWhen: (previous, current) {
        return previous.getProfileState != current.getProfileState;
      },
      builder: (context, state) {
        return state.getProfileState.when(
          initial: () => const Center(child: CircularProgressIndicator()),
          loading: () => const Center(child: CircularProgressIndicator()),
          success: (data) =>  UserDetailsColumn(imagePath: data.image),
          error: (error) => Center(child: Text(handleError(error) ?? '')),
        );
      },
    );
  }
}
