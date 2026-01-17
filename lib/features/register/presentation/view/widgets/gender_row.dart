import 'package:easy_localization/easy_localization.dart';
import 'package:elevate_flower_app/core/languages/locale_keys.g.dart';
import 'package:elevate_flower_app/core/theme/app_colors.dart';
import 'package:elevate_flower_app/core/utils/enums/Gender.dart';
import 'package:elevate_flower_app/features/register/presentation/view_model/cubit/register_cubit.dart';
import 'package:elevate_flower_app/features/register/presentation/view_model/cubit/register_events.dart';
import 'package:elevate_flower_app/features/register/presentation/view_model/cubit/register_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GenderRow extends StatelessWidget {
  const GenderRow({super.key});
  static const double _labelFontSize = 18;
  static const int _animationDuration = 300;
  static const double spaceBetween = 8;
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RegisterCubit>();
    return BlocBuilder<RegisterCubit, RegisterStates>(
      builder: (context, state) {
        return RadioGroup<Gender>(
          onChanged: (Gender? value) {
            cubit.doIntent(OnGenderSelectedEvent(value));
          },
          groupValue: state.genderRowState.selectedGender,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Text(
                      LocaleKeys.register_gender_label.tr(),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.gray53,
                        fontSize: _labelFontSize,
                      ),
                    ),
                  ),
                  const SizedBox(width: spaceBetween),
                  Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Radio<Gender>(value: Gender.female),
                        AnimatedDefaultTextStyle(
                          style: TextStyle(
                            color: state.genderRowState.selectedGender == Gender.female
                                ? AppColors.black0C
                                : AppColors.gray53,
                          ),
                          duration: const Duration(milliseconds: _animationDuration),
                          child: Text(LocaleKeys.register_female_label.tr()),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Radio<Gender>(value: Gender.male),
                        AnimatedDefaultTextStyle(
                          style: TextStyle(
                            color: state.genderRowState.selectedGender == Gender.male
                                ? AppColors.black0C
                                : AppColors.gray53,
                          ),
                          duration: const Duration(milliseconds: _animationDuration),
                          child: Text(LocaleKeys.register_male_label.tr()),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (state.genderRowState.showGenderError) ...[
                const SizedBox(height: spaceBetween),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    LocaleKeys.register_validation_gender_required.tr(),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.redCC,
                    ),
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
