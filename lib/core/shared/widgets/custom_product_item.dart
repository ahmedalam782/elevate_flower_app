import 'package:cached_network_image/cached_network_image.dart';
import 'package:elevate_flower_app/core/shared/entities/product_item_entity.dart';
import 'package:elevate_flower_app/core/shared/widgets/custom_button.dart';
import 'package:elevate_flower_app/core/theme/app_colors.dart';
import 'package:elevate_flower_app/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:shimmer/shimmer.dart';

class CustomProductItem extends StatelessWidget {
  final ProductItemEntity product;
  final VoidCallback? onTap;
  final VoidCallback? onAddToCart;
  final bool isLoading;

  const CustomProductItem({
    super.key,
    required this.product,
    this.onTap,
    this.onAddToCart,
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
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Container
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.pinkF9,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.r),
                    topRight: Radius.circular(16.r),
                  ),
                ),
                child: Stack(
                  children: [
                    // Product Image
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16.r),
                          topRight: Radius.circular(16.r),
                        ),
                        child: product.imageUrl != null
                            ? CachedNetworkImage(
                                imageUrl: product.imageUrl!,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                                placeholder: (context, url) =>
                                    Shimmer.fromColors(
                                      baseColor: AppColors.pinkF9,
                                      highlightColor: AppColors.whiteFF,
                                      child: Container(color: AppColors.pinkF9),
                                    ),
                                errorWidget: (context, url, error) => Container(
                                  color: AppColors.pinkF9,
                                  child: Icon(
                                    Icons.local_florist,
                                    size: 48.sp,
                                    color: AppColors.primerColor.withValues(
                                      alpha: 0.3,
                                    ),
                                  ),
                                ),
                              )
                            : Icon(
                                Icons.local_florist,
                                size: 48.sp,
                                color: AppColors.primerColor.withValues(
                                  alpha: 0.3,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Product Details
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.all(10.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Product Name
                    Text(
                      product.name ?? 'Product',
                      style: 14.medium.copyWith(color: AppColors.black0C),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                    // Spacer to push price and button to bottom
                    const Spacer(),

                    // Price Section with Discount Badge
                    Row(
                      children: [
                        // Current Price
                        Text(
                          'EGP ${hasDiscount ? product.priceAfterDiscount!.toStringAsFixed(0) : product.price?.toStringAsFixed(0) ?? '0'}',
                          style: 16.bold.copyWith(color: AppColors.black0C),
                        ),

                        Gap(6.w),

                        if (hasDiscount) ...[
                          // Original Price (strikethrough)
                          Text(
                            product.price?.toStringAsFixed(0) ?? '0',
                            style: 12.regular.copyWith(
                              color: AppColors.gray7D,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),

                          Gap(6.w),

                          // Discount Badge (after price)
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 6.w,
                              vertical: 2.h,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.green0C,
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Text(
                              '$discountPercentage%',
                              style: 11.bold.copyWith(color: AppColors.whiteFF),
                            ),
                          ),
                        ],
                      ],
                    ),

                    Gap(6.h),

                    // Add to Cart Button
                    SizedBox(
                      width: double.infinity,
                      height: 34.h,
                      child: CustomButton(
                        onPressed: onAddToCart,
                        title: 'Add to cart',
                        titleStyle: 13.semiBold.copyWith(
                          color: AppColors.whiteFF,
                        ),
                        leading: Icon(
                          Icons.shopping_cart_outlined,
                          size: 16.sp,
                          color: AppColors.whiteFF,
                        ),
                        isExpanded: true,
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
                        borderRadius: BorderRadius.circular(4.r),
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
                            borderRadius: BorderRadius.circular(4.r),
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
                            borderRadius: BorderRadius.circular(4.r),
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
                        borderRadius: BorderRadius.circular(12.r),
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
