import 'package:easy_localization/easy_localization.dart';
import '../../../../../core/languages/locale_keys.g.dart';
import '../../../../../core/routes/routes.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_typography.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DoNotHaveAccount extends StatelessWidget {
  const DoNotHaveAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text.rich(
        TextSpan(
          text: LocaleKeys.login_no_account.tr(),
          style: 14.regular.copyWith(
            color: AppColors.black0C,
            fontWeight: FontWeight.bold,
          ),
          children: [
            TextSpan(
              text: ' ${LocaleKeys.login_sign_up.tr()}',
              style: 14.semiBold.copyWith(
                color: AppColors.primerColor,
                decoration: TextDecoration.underline,
                decorationColor: AppColors.primerColor,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  context.push(Routes.register);
                },
            ),
          ],
        ),
      ),
    );

    //!================= OLD Do Not Have Account CODE ===================

    // Row(
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   children: [
    //     Text(
    //       LocaleKeys.login_no_account.tr(),
    //       style: 14.regular.copyWith(color: AppColors.black0C),
    //     ),
    //     TextButton(
    //       onPressed: () {
    //         context.push(Routes.register);
    //       },
    //       style: TextButton.styleFrom(
    //         padding: EdgeInsets.zero,
    //         minimumSize: Size.zero,
    //         tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    //       ),
    //       child: Text(
    //         LocaleKeys.login_sign_up.tr(),
    //         style: 14.semiBold.copyWith(
    //           color: AppColors.primerColor,
    //         ),
    //       ),
    //     ),
    //   ],
    // ),
    //!================= OLD Do Not Have Account CODE ===================
  }
}
