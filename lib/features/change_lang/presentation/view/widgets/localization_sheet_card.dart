import 'package:easy_localization/easy_localization.dart';
import 'package:elevate_flower_app/core/languages/lang.dart';
import 'package:elevate_flower_app/core/languages/locale_keys.g.dart';
import 'package:elevate_flower_app/core/theme/app_colors.dart';
import 'package:elevate_flower_app/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class LocalizationSheetCard extends StatelessWidget {
  const LocalizationSheetCard({
    super.key,
    required this.language,
    required this.isSelected,
    required this.onTap,
  });
  final LanguageType language;
  final bool isSelected;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.symmetric(vertical: 18.5, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              language == LanguageType.arabic
                  ? LocaleKeys.change_language_arabic.tr()
                  : LocaleKeys.change_language_english.tr(),
              style: 16.medium.copyWith(color: AppColors.black0C),
            ),
            _selectionIndicator(isSelected),
          ],
        ),
      ),
    );
  }
}

Widget _selectionIndicator(bool isSelected) {
  return AnimatedContainer(
    duration: const Duration(milliseconds: 300),
    curve: Curves.easeInOut,
    width: 22,
    height: 22,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(
        color: isSelected ? AppColors.primerColor : AppColors.grayA6,
        width: 2,
      ),
    ),
    child: isSelected
        ? Center(
            child: Container(
              width: 12,
              height: 12,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primerColor,
              ),
            ),
          )
        : null,
  );
}
