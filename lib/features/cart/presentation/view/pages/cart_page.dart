import 'package:easy_localization/easy_localization.dart';
import 'package:elevate_flower_app/core/languages/locale_keys.g.dart';
import 'package:elevate_flower_app/core/shared/widgets/custom_button.dart';
import 'package:elevate_flower_app/core/theme/app_colors.dart';
import 'package:elevate_flower_app/core/theme/app_typography.dart';
import 'package:elevate_flower_app/features/cart/presentation/view/widgets/cart_item.dart';
import 'package:elevate_flower_app/features/cart/presentation/view/widgets/cart_upper_part.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            CartUpperPart(),
            SizedBox(height: 24.h),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return CartItem();
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: 24.h);
                },
                itemCount: 10,
              ),
            ),
            SizedBox(height: 32.h),
            Divider(color: AppColors.grayA6, thickness: 0.5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(LocaleKeys.cart_total.tr(), style: 18.medium),
                Text("110 ${LocaleKeys.products_EGP.tr()}", style: 18.medium),
              ],
            ),
            SizedBox(height: 32.h),
            CustomButton(
              radius: 20.r,
              title: LocaleKeys.cart_check_out.tr(),
              borderColor: Colors.transparent,
              onPressed: () {},
            ),
            SizedBox(height: 32.h),
          ],
        ),
      ),
    );
  }
}
