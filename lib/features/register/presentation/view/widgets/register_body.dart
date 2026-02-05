import 'package:easy_localization/easy_localization.dart';
import '../../../../../core/languages/locale_keys.g.dart';
import '../../../../../core/shared/widgets/custom_button.dart';
import 'already_have_account.dart';
import 'gender_row.dart';
import 'register_bloc_listner.dart';
import 'register_form.dart';
import 'terms_conditions_span.dart';
import '../../view_model/cubit/register_cubit.dart';
import '../../view_model/cubit/register_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/config/base_state/base_state.dart';
import '../../view_model/cubit/register_states.dart';

class RegisterBody extends StatelessWidget {
  const RegisterBody({super.key});
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RegisterCubit>();
    return Column(
      children: [
        const RegisterForm(),
        const SizedBox(height: 24.0),
        BlocBuilder<RegisterCubit, RegisterStates>(
          builder: (context, state) {
            return GenderRow(
              selectedGender: state.genderRowState.selectedGender,
              showError: state.genderRowState.showGenderError,
              onChanged: (gender) {
                cubit.doIntent(OnGenderSelectedEvent(gender));
              },
            );
          },
        ),
        const SizedBox(height: 24.0),
        const TermsConditionsSpan(),
        const SizedBox(height: 50.0),
        BlocBuilder<RegisterCubit, RegisterStates>(
          builder: (context, state) {
            return CustomButton(
              title: LocaleKeys.register_register_button.tr(),
              isLoading: state.registerState.state == StateType.loading,
              onPressed: () {
                cubit.doIntent(const RegisterUserEvent());
              },
              borderColor: Colors.transparent,
            );
          },
        ),
        const SizedBox(height: 16.0),
        const AlreadyHaveAccount(),
        const RegisterBlocListener(),
      ],
    );
  }
}
