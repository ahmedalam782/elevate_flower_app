import 'package:easy_localization/easy_localization.dart';
import '../../../../../core/config/di/injectable_config.dart';
import '../../../../../core/languages/locale_keys.g.dart';
import '../../../../../core/shared/widgets/custom_app_bar.dart';
import '../widgets/edit_profile_body.dart';
import '../../view_model/cubit/edit_profile_cubit.dart';
import '../../view_model/cubit/edit_profile_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfilePage extends StatelessWidget {
  EditProfilePage({super.key});
  final _cubit = getIt<EditProfileCubit>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.edit_profile_edit_profile_title.tr(),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {
              // todo: implement action
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: BlocProvider<EditProfileCubit>(
              create: (context) =>
                  _cubit..onEvent(EditProfileEvents.fillFormEvent()),
              child: const EditProfileBody(),
            ),
          ),
        ),
      ),
    );
  }
}
