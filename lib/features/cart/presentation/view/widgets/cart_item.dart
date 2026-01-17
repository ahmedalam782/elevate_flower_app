import 'package:easy_localization/easy_localization.dart';
import 'package:elevate_flower_app/core/languages/locale_keys.g.dart';
import 'package:elevate_flower_app/core/shared/widgets/optimized_cached_image.dart';
import 'package:elevate_flower_app/core/theme/app_colors.dart';
import 'package:elevate_flower_app/core/theme/app_images.dart';
import 'package:elevate_flower_app/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CartItem extends StatelessWidget {
  const CartItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      height: 100.w,
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(width: 0.5, color: AppColors.gray53),
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.pinkF9,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: OptimizedCachedImage(
              imageUrl: "https://placehold.co/600x400",
              width: 100.w,
              height: 100.w,
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: SizedBox(
              height: 100.w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Red roses",
                              style: 16.medium,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              "15 Pink Rose Bouquet",
                              style: 13.medium.copyWith(
                                color: AppColors.gray53,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      SvgPicture.asset(AppImages.deleteTrash),
                      // Icon(Icons.delete_outline, color: AppColors.redCC),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${LocaleKeys.products_EGP.tr()}",
                          style: 14.semiBold,
                        ),
                      ),

                      Row(
                        children: [
                          Icon(Icons.remove_rounded),
                          SizedBox(width: 5.w),
                          Text("1", style: 14.semiBold),
                          SizedBox(width: 5.w),

                          Icon(Icons.add_rounded),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
