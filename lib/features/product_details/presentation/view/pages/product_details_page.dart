import 'package:easy_localization/easy_localization.dart';
import 'package:elevate_flower_app/core/languages/locale_keys.g.dart';
import 'package:elevate_flower_app/core/shared/widgets/custom_button.dart';
import 'package:elevate_flower_app/core/theme/app_colors.dart';
import 'package:elevate_flower_app/core/theme/app_typography.dart';
import 'package:elevate_flower_app/features/product_details/presentation/view/widgets/product_image_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({super.key});

  static const double expandedHeight = 450;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              /// 🔥 SLIVER WITH REAL COLLAPSE AWARENESS
              SliverLayoutBuilder(
                builder: (context, constraints) {
                  final double scrollOffset = constraints.scrollOffset;
                  final bool isCollapsed =
                      scrollOffset > (expandedHeight - kToolbarHeight + 75.h);

                  return SliverAppBar(
                    expandedHeight: expandedHeight.h,
                    pinned: true,
                    stretch: true,
                    elevation: 0,
                    backgroundColor: AppColors.whiteF9,
                    leading: IconButton(
                      icon: const Icon(Icons.chevron_left, color: Colors.black),
                      onPressed: () => Navigator.pop(context),
                    ),

                    /// ✅ TITLE APPEARS ONLY WHEN COLLAPSED
                    title: AnimatedOpacity(
                      duration: const Duration(milliseconds: 200),
                      opacity: isCollapsed ? 1 : 0,
                      child: Text("15 Pink Rose Bouquet", style: 16.semiBold),
                    ),

                    flexibleSpace: const FlexibleSpaceBar(
                      collapseMode: CollapseMode.parallax,
                      background: ProductImageSlider(),
                    ),
                  );
                },
              ),

              /// 🧾 CONTENT (FORCES SCROLL EVEN IF SHORT)
              SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16.h),

                      /// PRICE + STATUS
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${LocaleKeys.product_details_EGP.tr()} 1,500",
                            style: 20.bold,
                          ),
                          Row(
                            children: [
                              Text(
                                LocaleKeys.product_details_status.tr(),
                                style: 16.medium,
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                LocaleKeys.product_details_in_stock.tr(),
                                style: 14.regular,
                              ),
                            ],
                          ),
                        ],
                      ),

                      SizedBox(height: 4.h),
                      Text(
                        LocaleKeys.product_details_all_prices_include_taxes
                            .tr(),
                        style: 13.regular.copyWith(color: AppColors.gray53),
                        // style: TextStyle(
                        //   fontSize: 13.sp,
                        //   color: AppColors.gray53,
                        // ),
                      ),

                      SizedBox(height: 8.h),
                      Text("15 Pink Rose Bouquet", style: 18.semiBold),

                      SizedBox(height: 24.h),

                      /// DESCRIPTION
                      Text(
                        LocaleKeys.product_details_description.tr(),
                        style: 16.medium,

                        // TextStyle(
                        //   fontSize: 16.sp,
                        //   fontWeight: FontWeight.w500,
                        // ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        "Lorem ipsum dolor sit amet consectetur. orem ipsum dolor sit amet consectetur.orem ipsum dolor sit amet consectetur.orem ipsum dol Lorem ipsum dolor sit amet consectetur. orem ipsum dolor sit amet consectetur.orem ipsum dolor sit amet consectetur.orem ipsum dol Lorem ipsum dolor sit amet consectetur. orem ipsum dolor sit amet consectetur.orem ipsum dolor sit amet consectetur.orem ipsum dol Lorem ipsum dolor sit amet consectetur. orem ipsum dolor sit amet consectetur.orem ipsum dolor sit amet consectetur.orem ipsum dol Lorem ipsum dolor sit amet consectetur. orem ipsum dolor sit amet consectetur.orem ipsum dolor sit amet consectetur.orem ipsum dol Lorem ipsum dolor sit amet consectetur. orem ipsum dolor sit amet consectetur.orem ipsum dolor sit amet consectetur.orem ipsum dol Lorem ipsum dolor sit amet consectetur. orem ipsum dolor sit amet consectetur.orem ipsum dolor sit amet consectetur.orem ipsum dol Lorem ipsum dolor sit amet consectetur. orem ipsum dolor sit amet consectetur.orem ipsum dolor sit amet consectetur.orem ipsum dol Lorem ipsum dolor sit amet consectetur. orem ipsum dolor sit amet consectetur.orem ipsum dolor sit amet consectetur.orem ipsum dol",
                        style: 14.regular,
                      ),

                      SizedBox(height: 24.h),

                      /// INCLUDED
                      Text(
                        LocaleKeys.product_details_bouqet_include.tr(),
                        style: 16.medium,
                      ),
                      SizedBox(height: 4.h),
                      Text("Pink roses: 15", style: 14.regular),
                      Text("White wrap", style: 14.regular),

                      const Spacer(), // 👈 forces collapse even with short content
                      SizedBox(height: 120.h),
                    ],
                  ),
                ),
              ),
            ],
          ),

          /// 🛒 FIXED ADD TO CART
          Positioned(
            bottom: 24.h,
            left: 16.w,
            right: 16.w,
            child: CustomButton(
              onPressed: () {},
              title: LocaleKeys.product_details_add_to_cart.tr(),
            ),
          ),
        ],
      ),
    );
  }
}
