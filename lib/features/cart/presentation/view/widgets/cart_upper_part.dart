import 'package:easy_localization/easy_localization.dart';
import 'package:elevate_flower_app/core/languages/locale_keys.g.dart';
import 'package:elevate_flower_app/core/theme/app_colors.dart';
import 'package:elevate_flower_app/core/theme/app_images.dart';
import 'package:elevate_flower_app/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CartUpperPart extends StatelessWidget {
  const CartUpperPart({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 16.h),
        Row(
          children: [
            Text(LocaleKeys.cart_cart.tr(), style: 20.medium),
            SizedBox(width: 4.w),
            Text(
              "(3 ${LocaleKeys.cart_items.tr()})",
              style: 20.medium.copyWith(color: AppColors.gray53),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            SvgPicture.asset(AppImages.locationSvg),

            const SizedBox(width: 4),
            Text(
              LocaleKeys.cart_deliver_to.tr(),

              style: TextStyle(fontSize: 16.sp, color: AppColors.gray53),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                "2XVP+XC - Sheikh Zayed.....",
                style: 16.medium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Icon(Icons.keyboard_arrow_down, size: 36, color: AppColors.gray53),
          ],
        ),
      ],
    );
  }
}
