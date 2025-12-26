import 'package:easy_localization/easy_localization.dart';
import 'package:elevate_flower_app/core/languages/locale_keys.g.dart';
import 'package:elevate_flower_app/core/shared/widgets/custom_button.dart';
import 'package:elevate_flower_app/features/register/presentation/view/widgets/already_have_account.dart';
import 'package:elevate_flower_app/features/register/presentation/view/widgets/gender_row.dart';
import 'package:elevate_flower_app/features/register/presentation/view/widgets/register_bloc_listner.dart';
import 'package:elevate_flower_app/features/register/presentation/view/widgets/register_form.dart';
import 'package:elevate_flower_app/features/register/presentation/view/widgets/terms_conditions_span.dart';
import 'package:elevate_flower_app/features/register/presentation/view_model/cubit/register_cubit.dart';
import 'package:elevate_flower_app/features/register/presentation/view_model/cubit/register_events.dart';
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
        RegisterForm(),
        SizedBox(height: 24.0),
        GenderRow(),
        SizedBox(height: 24.0),
        TermsConditionsSpan(),
        SizedBox(height: 50.0),
        BlocBuilder<RegisterCubit, RegisterStates>(
          builder: (context, state) {
            return CustomButton(
              title: LocaleKeys.register_register_button.tr(),
              isLoading: state.registerState.state == StateType.loading,
              onPressed: () {
                cubit.doIntent(RegisterUserEvent());
              },
              borderColor: Colors.transparent,
            );
          },
        ),
        SizedBox(height: 16.0),
        AlreadyHaveAccount(),
        RegisterBlocListener(),
      ],
    );
  }
}
