import 'package:easy_localization/easy_localization.dart';
import '../entities/product_item_entity.dart';
import 'custom_button.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_typography.dart';
import '../../../features/cart/presentation/view/widgets/custom_add_to_cart_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:shimmer/shimmer.dart';

import '../../languages/locale_keys.g.dart';
import 'custom_cached_image.dart';

class CustomProductItem extends StatelessWidget {
  final ProductItemEntity product;
  final VoidCallback? onTap;
  final VoidCallback? onAddToCart;
  final VoidCallback? onIncrement;
  final VoidCallback? onDecrement;
  final VoidCallback? onRemove;
  final int quantity;
  final bool isLoading;

  const CustomProductItem({
    super.key,
    required this.product,
    this.onTap,
    this.onAddToCart,
    this.onIncrement,
    this.onDecrement,
    this.onRemove,
    this.quantity = 0,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return _buildShimmerLoading();
    }

    final hasDiscount =
        product.priceAfterDiscount != null &&
        product.priceAfterDiscount! > 0 &&
        product.priceAfterDiscount! < (product.price ?? 0);

    final discountPercentage = hasDiscount
        ? (((product.price! - product.priceAfterDiscount!) / product.price!) *
                  100)
              .round()
        : 0;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: AppColors.whiteFF,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.grayA6, width: .5),
        ),
        child: Column(
          spacing: 8,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Container
            Expanded(
              flex: 6,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.pinkF9,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: CustomCachedImage(
                  imagePath: product.imageUrl ?? '',
                  fit: BoxFit.contain,
                ),
              ),
            ),

            // Product Details
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Name
                    Text(
                      product.name ?? 'Product',
                      style: 12.regular,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Gap(4),
                    // Price Section with Discount Badge
                    Row(
                      spacing: 6,
                      children: [
                        // Current Price
                        Text(
                          '${LocaleKeys.products_EGP.tr()} ${hasDiscount ? product.priceAfterDiscount!.toStringAsFixed(0) : product.price?.toStringAsFixed(0) ?? '0'}',
                          style: 14.medium,
                        ),

                        if (hasDiscount) ...[
                          // Original Price (strikethrough)
                          Text(
                            product.price?.toStringAsFixed(0) ?? '0',
                            style: 12.regular.copyWith(
                              color: AppColors.gray7D,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),

                          // Discount Badge (after price)
                          Text(
                            '$discountPercentage%',
                            style: 12.regular.copyWith(
                              color: AppColors.green0C,
                            ),
                          ),
                        ],
                      ],
                    ),
                    const Spacer(),

                    // Add to Cart Button or Quantity Controls
                    quantity == 0
                        ? CustomButton(
                            onPressed: () {
                              addToCart(context, product.id);
                            },
                            title: LocaleKeys.products_add_to_cart.tr(),
                            titleStyle: 13.medium.copyWith(
                              color: AppColors.whiteF9,
                            ),
                            height: 28,
                            padding: const EdgeInsets.symmetric(
                              vertical: 0,
                              horizontal: 0,
                            ),
                            leading: const Icon(
                              Icons.shopping_cart_outlined,
                              size: 14,
                              color: AppColors.whiteF9,
                            ),
                          )
                        : _buildQuantityControls(),
                    const Gap(8),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuantityControls() {
    return Container(
      height: 30,
      decoration: BoxDecoration(
        color: AppColors.primerColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Decrement Button
          GestureDetector(
            onTap: () {
              if (quantity == 1) {
                onRemove?.call();
              } else {
                onDecrement?.call();
              }
            },
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: AppColors.primerColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(
                quantity == 1 ? Icons.delete_outline : Icons.remove,
                color: AppColors.whiteFF,
                size: 16,
              ),
            ),
          ),

          // Quantity Display
          Expanded(
            child: Center(
              child: Text(
                '$quantity',
                style: 13.medium.copyWith(color: AppColors.whiteFF),
              ),
            ),
          ),

          // Increment Button
          GestureDetector(
            onTap: onIncrement,
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: AppColors.primerColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Icon(Icons.add, color: AppColors.whiteFF, size: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerLoading() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: AppColors.whiteFF,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Shimmer.fromColors(
        baseColor: AppColors.grayCF.withValues(alpha: 0.3),
        highlightColor: AppColors.whiteFF,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Shimmer
            Expanded(
              flex: 3,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                decoration: BoxDecoration(
                  color: AppColors.whiteFF,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.r),
                    topRight: Radius.circular(16.r),
                  ),
                ),
              ),
            ),

            // Details Shimmer
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.all(10.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Name shimmer
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                      height: 14.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.whiteFF,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),

                    const Spacer(),

                    // Price shimmer
                    Row(
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                          height: 16.h,
                          width: 80.w,
                          decoration: BoxDecoration(
                            color: AppColors.whiteFF,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        Gap(8.w),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                          height: 12.h,
                          width: 40.w,
                          decoration: BoxDecoration(
                            color: AppColors.whiteFF,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ],
                    ),

                    Gap(6.h),

                    // Button shimmer
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                      height: 34.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.whiteFF,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
