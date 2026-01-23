import 'package:easy_localization/easy_localization.dart';
import 'package:elevate_flower_app/core/languages/locale_keys.g.dart';
import 'package:elevate_flower_app/core/theme/app_colors.dart';
import 'package:elevate_flower_app/core/utils/enums/gender.dart';
import 'package:flutter/material.dart';

class GenderRow extends StatelessWidget {
  const GenderRow({
    super.key,
    required this.selectedGender,
    required this.onChanged,
    this.showError = false,
  });

  final Gender? selectedGender;
  final ValueChanged<Gender?> onChanged;
  final bool showError;
  static const double _labelFontSize = 18;
  static const double spaceBetween = 8;

  @override
  Widget build(BuildContext context) {
    return RadioGroup<Gender>(
      groupValue: selectedGender,
      onChanged: onChanged,
      child: Column(
        children: [
          Row(
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
              _GenderOption(
                value: Gender.female,
                label: LocaleKeys.register_female_label.tr(),
                selectedGender: selectedGender,
              ),
              _GenderOption(
                value: Gender.male,
                label: LocaleKeys.register_male_label.tr(),
                selectedGender: selectedGender,
              ),
            ],
          ),
          if (showError) ...[
            const SizedBox(height: spaceBetween),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                LocaleKeys.register_validation_gender_required.tr(),
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: AppColors.redCC),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _GenderOption extends StatelessWidget {
  const _GenderOption({
    required this.value,
    required this.label,
    required this.selectedGender,
  });

  final Gender value;
  final String label;
  final Gender? selectedGender;
  static const int _animationDuration = 300;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Radio<Gender>(value: value),
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: _animationDuration),
            style: TextStyle(
              color: selectedGender == value
                  ? AppColors.black0C
                  : AppColors.gray53,
            ),
            child: Text(label),
          ),
        ],
      ),
    );
  }
}
