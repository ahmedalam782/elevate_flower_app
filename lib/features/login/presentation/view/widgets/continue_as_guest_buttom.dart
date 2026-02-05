import 'package:easy_localization/easy_localization.dart';
import '../../../../../core/languages/locale_keys.g.dart';
import '../../../../../core/routes/routes.dart';
import '../../../../../core/shared/widgets/custom_button.dart';
import '../../../../../core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ContinueAsGuestButtom extends StatelessWidget {
  const ContinueAsGuestButtom({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      title: LocaleKeys.login_continue_as_guest.tr(),
      onPressed: () {
        context.go(Routes.appLayout);
      },
      isFilled: false,
      borderColor: AppColors.grayA6,
      backGroundColor: AppColors.gray53,
    );
  }
}
