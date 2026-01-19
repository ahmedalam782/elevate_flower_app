import 'package:easy_localization/easy_localization.dart';
import 'package:elevate_flower_app/core/config/di/injectable_config.dart';
import 'package:elevate_flower_app/core/languages/lang.dart';
import 'package:elevate_flower_app/core/languages/locale_keys.g.dart';
import 'package:elevate_flower_app/core/theme/app_colors.dart';
import 'package:elevate_flower_app/core/theme/app_typography.dart';
import 'package:elevate_flower_app/features/change_lang/domain/use_cases/change_lang_use_case.dart';
import 'package:elevate_flower_app/features/change_lang/presentation/view/widgets/localization_sheet_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LocalizationBottomSheet extends StatefulWidget {
  const LocalizationBottomSheet({super.key});

  @override
  State<LocalizationBottomSheet> createState() =>
      _LocalizationBottomSheetState();
}

class _LocalizationBottomSheetState extends State<LocalizationBottomSheet> {
  @override
  Widget build(BuildContext context) {
    final currentLang = context.locale.languageCode;
    ChangeLangUseCase changeLangUseCase = getIt<ChangeLangUseCase>();

    return SizedBox(
      height: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              LocaleKeys.change_language_title.tr(),
              style: 20.bold.copyWith(color: AppColors.pink7C),
            ),
          ),
          LocalizationSheetCard(
            language: LanguageType.english,
            isSelected: currentLang == 'en',
            onTap: () {
              changeLangUseCase.call(locale: englishLocale, context: context);
              context.pop();
            },
          ),
          LocalizationSheetCard(
            language: LanguageType.arabic,
            isSelected: currentLang == 'ar',
            onTap: () {
              changeLangUseCase.call(locale: arabicLocale, context: context);
              context.pop();
            },
          ),
        ],
      ),
    );
  }
}

void showLocalizationBottomSheet(BuildContext context) {
  showModalBottomSheet(
    useRootNavigator: false,
    context: context,
    builder: (context) => const LocalizationBottomSheet(),
  );
}
