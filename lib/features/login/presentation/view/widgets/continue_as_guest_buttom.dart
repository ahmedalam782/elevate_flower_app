import 'package:easy_localization/easy_localization.dart';
import 'package:elevate_flower_app/core/languages/locale_keys.g.dart';
import 'package:elevate_flower_app/core/routes/routes.dart';
import 'package:elevate_flower_app/core/shared/widgets/custom_button.dart';
import 'package:elevate_flower_app/core/theme/app_colors.dart';
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
