import 'package:easy_localization/easy_localization.dart';
import 'package:elevate_flower_app/core/languages/locale_keys.g.dart';
import 'package:elevate_flower_app/core/theme/app_colors.dart';
import 'package:elevate_flower_app/core/utils/enums/Gender.dart';
import 'package:flutter/material.dart';

class GenderRow extends StatefulWidget {
  const GenderRow({super.key});

  @override
  State<GenderRow> createState() => _GenderRowState();
}

class _GenderRowState extends State<GenderRow> {
  Gender? _selectedGender;

  @override
  Widget build(BuildContext context) {
    return RadioGroup<Gender>(
      onChanged: (Gender? value) {
        // Handle gender selection
        setState(() {
          _selectedGender = value;
        });
      },
      groupValue: _selectedGender,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: Text(
              LocaleKeys.register_gender_label.tr(),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.gray53,
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Radio<Gender>(value: Gender.female),
                AnimatedDefaultTextStyle(
                  style: TextStyle(
                    color: _selectedGender == Gender.female
                        ? AppColors.black0C
                        : AppColors.gray53,
                  ),
                  duration: Duration(milliseconds: 300),
                  child: Text(LocaleKeys.register_female_label.tr()),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Radio<Gender>(value: Gender.male),
                AnimatedDefaultTextStyle(
                  style: TextStyle(
                    color: _selectedGender == Gender.male
                        ? AppColors.black0C
                        : AppColors.gray53,
                  ),
                  duration: Duration(milliseconds: 300),
                  child: Text(LocaleKeys.register_male_label.tr()),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
