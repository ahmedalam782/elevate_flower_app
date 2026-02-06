import 'package:easy_localization/easy_localization.dart';
import '../../../../../core/languages/lang.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_typography.dart';

import '../../../../../core/languages/locale_keys.g.dart';

/// Language selection bottom sheet
class LanguageBottomSheet extends StatelessWidget {
  final String currentLanguage;
  final Function(Locale) onLanguageSelected;

  const LanguageBottomSheet({
    super.key,
    required this.currentLanguage,
    required this.onLanguageSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            LocaleKeys.profile_change_language.tr(),
            style: 18.semiBold.copyWith(color: AppColors.black32),
          ),
          SizedBox(height: 20.h),
          // English Option
          _LanguageOption(
            language: LocaleKeys.profile_English.tr(),
            locale: englishLocale,
            isSelected: currentLanguage == english,
            onTap: () {
              onLanguageSelected(englishLocale);
              Navigator.pop(context);
            },
          ),
          SizedBox(height: 12.h),
          // Arabic Option
          _LanguageOption(
            language: LocaleKeys.profile_Arabic.tr(),
            locale: arabicLocale,
            isSelected: currentLanguage == arabic,
            onTap: () {
              onLanguageSelected(arabicLocale);
              Navigator.pop(context);
            },
          ),
          SizedBox(height: 40.h),
        ],
      ),
    );
  }
}

class _LanguageOption extends StatelessWidget {
  final String language;
  final Locale locale;
  final bool isSelected;
  final VoidCallback onTap;

  const _LanguageOption({
    required this.language,
    required this.locale,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected
                ? AppColors.primerColor
                : AppColors.blackCE.withValues(alpha: 0.3),
            width: isSelected ? 2.w : 1.w,
          ),
          borderRadius: BorderRadius.circular(8.r),
          boxShadow:[
             BoxShadow(
              color: AppColors.black.withValues(alpha: 0.10),
              offset: const Offset(0, 0),
              blurRadius: 5,
            ),
          ],
          color: isSelected ? AppColors.pinkF9 : AppColors.whiteFF,
        ),
        child: Row(
          children: [
            // Radio button
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              width: 20.w,
              height: 20.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? AppColors.primerColor : AppColors.black85,
                  width: 2.w,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        width: 10.w,
                        height: 10.h,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primerColor,
                        ),
                      ),
                    )
                  : null,
            ),
            SizedBox(width: 12.w),
            // Language text
            Text(
              language,
              style: isSelected
                  ? 16.semiBold.copyWith(color: AppColors.primerColor)
                  : 16.regular.copyWith(color: AppColors.black32),
            ),
          ],
        ),
      ),
    );
  }
}
