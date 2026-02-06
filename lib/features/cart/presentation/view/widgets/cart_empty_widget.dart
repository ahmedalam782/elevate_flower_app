import 'package:easy_localization/easy_localization.dart';
import '../../../../../core/languages/locale_keys.g.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_images.dart';
import '../../../../../core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CartEmptyWidget extends StatelessWidget {
  const CartEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Transform.scale(
            scale: 2,
            child: SvgPicture.asset(AppImages.emptyCartIcon),
          ),
          SizedBox(height: 12.h),
          Text(
            LocaleKeys.cart_no_items_found.tr(),
            textAlign: TextAlign.center,
            style: 18.medium.copyWith(color: AppColors.primerColor),
          ),
        ],
      ),
    );
  }
}
