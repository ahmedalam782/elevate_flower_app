import 'package:easy_localization/easy_localization.dart';
import 'package:elevate_flower_app/core/languages/locale_keys.g.dart';
import 'package:elevate_flower_app/core/shared/widgets/optimized_cached_image.dart';
import 'package:elevate_flower_app/core/theme/app_colors.dart';
import 'package:elevate_flower_app/core/theme/app_images.dart';
import 'package:elevate_flower_app/core/theme/app_typography.dart';
import 'package:elevate_flower_app/features/cart/domain/entities/cart_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CartItemWidget extends StatelessWidget {
  final CartProductEntity cartProduct;

  final Function() onAddFunction;
  final Function() onRemoveFunction;
  final Function() onDecrementFunction;
  const CartItemWidget({
    super.key,
    required this.cartProduct,

    required this.onAddFunction,
    required this.onRemoveFunction,
    required this.onDecrementFunction,
  });

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
              imageUrl: cartProduct.productImage,
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
                              cartProduct.productName,
                              style: 16.medium,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              cartProduct.productDescription,
                              style: 13.medium.copyWith(
                                color: AppColors.gray53,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: onRemoveFunction,
                        child: SizedBox(
                          width: 18.w,
                          height: 18.w,
                          child: SvgPicture.asset(AppImages.deleteTrash),
                        ),
                      ),

                      // Icon(Icons.delete_outline, color: AppColors.redCC),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${cartProduct.productPrice} ${LocaleKeys.products_EGP.tr()}",
                          style: 14.semiBold,
                        ),
                      ),

                      Row(
                        children: [
                          InkWell(
                            onTap: onDecrementFunction,
                            child: SizedBox(
                              width: 20.w,
                              height: 20.w,
                              child: Icon(Icons.remove_rounded),
                            ),
                          ),

                          SizedBox(width: 5.w),
                          Text(
                            cartProduct.productQuantityInCart.toString(),
                            style: 14.semiBold,
                          ),
                          SizedBox(width: 5.w),
                          InkWell(
                            onTap: onAddFunction,
                            child: SizedBox(
                              width: 20.w,
                              height: 20.w,
                              child: Icon(Icons.add_rounded),
                            ),
                          ),
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
