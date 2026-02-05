import 'package:easy_localization/easy_localization.dart';
import '../../../../../core/languages/locale_keys.g.dart';
import '../../../../../core/routes/routes.dart';
import '../../../../../core/shared/widgets/custom_button.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class NotAutenticatedUserWidget extends StatelessWidget {
  const NotAutenticatedUserWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            LocaleKeys.cart_browsing_as_guest.tr(),
            style: 16.medium.copyWith(color: AppColors.primerColor),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 12.h),
          CustomButton(
            radius: 20.r,
            title: LocaleKeys.login_title.tr(),
            borderColor: Colors.transparent,
            onPressed: () {
              context.go(Routes.login);
            },
          ),
        ],
      ),
    );
  }
}
