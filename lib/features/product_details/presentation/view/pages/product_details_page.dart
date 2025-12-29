import 'package:easy_localization/easy_localization.dart';
import 'package:elevate_flower_app/core/config/base_state/base_state.dart';
import 'package:elevate_flower_app/core/config/di/injectable_config.dart';
import 'package:elevate_flower_app/core/errors/failures.dart';
import 'package:elevate_flower_app/core/languages/locale_keys.g.dart';
import 'package:elevate_flower_app/core/shared/widgets/custom_button.dart';
import 'package:elevate_flower_app/core/theme/app_colors.dart';
import 'package:elevate_flower_app/core/theme/app_typography.dart';
import 'package:elevate_flower_app/features/product_details/presentation/view/widgets/product_image_slider.dart';
import 'package:elevate_flower_app/features/product_details/presentation/view_model/cubit/product_details_cubit.dart';
import 'package:elevate_flower_app/features/product_details/presentation/view_model/cubit/product_details_events.dart';
import 'package:elevate_flower_app/features/product_details/presentation/view_model/cubit/product_details_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductDetailsPage extends StatefulWidget {
  final String productId;
  const ProductDetailsPage({super.key, required this.productId});

  static const double expandedHeight = 450;

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  final viewModel = getIt<ProductDetailsCubit>();

  @override
  void initState() {
    viewModel.doIntent(GetSpeceficProductEvent(productId: widget.productId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => viewModel,
      child: BlocBuilder<ProductDetailsCubit, ProductDetailsStates>(
        builder: (context, state) {
          final currentState = state.state.state;
          return Scaffold(
            body: currentState == StateType.loading
                ? Center(child: CircularProgressIndicator())
                : currentState == StateType.error
                ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            (state.state.exception as Failures).errorMessage,
                            // maxLines: 1,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: AppColors.primerColor,
                            ),
                          ),

                          SizedBox(height: 8.h),
                          CustomButton(
                            title: LocaleKeys.global_try_again.tr(),
                            onPressed: () {
                              viewModel.doIntent(
                                GetSpeceficProductEvent(
                                  productId: widget.productId,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  )
                : Stack(
                    children: [
                      CustomScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        slivers: [
                          /// 🔥 SLIVER WITH REAL COLLAPSE AWARENESS
                          SliverLayoutBuilder(
                            builder: (context, constraints) {
                              final double scrollOffset =
                                  constraints.scrollOffset;
                              final bool isCollapsed =
                                  scrollOffset >
                                  (ProductDetailsPage.expandedHeight -
                                      kToolbarHeight +
                                      75.h);

                              return SliverAppBar(
                                expandedHeight:
                                    ProductDetailsPage.expandedHeight.h,
                                pinned: true,
                                stretch: true,
                                elevation: 0,
                                backgroundColor: AppColors.whiteF9,
                                leading: IconButton(
                                  icon: const Icon(
                                    Icons.chevron_left,
                                    color: Colors.black,
                                  ),
                                  onPressed: () => Navigator.pop(context),
                                ),

                                /// ✅ TITLE APPEARS ONLY WHEN COLLAPSED
                                title: AnimatedOpacity(
                                  duration: const Duration(milliseconds: 200),
                                  opacity: isCollapsed ? 1 : 0,
                                  child: Text(
                                    state.state.data?.productName ?? "",
                                    style: 16.semiBold,
                                  ),
                                ),

                                flexibleSpace: FlexibleSpaceBar(
                                  collapseMode: CollapseMode.parallax,
                                  background: ProductImageSlider(
                                    images:
                                        state.state.data?.productImages ?? [],
                                  ),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${LocaleKeys.product_details_EGP.tr()} ${state.state.data?.productPrice}",
                                        style: 20.bold,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            LocaleKeys.product_details_status
                                                .tr(),
                                            style: 16.medium,
                                          ),
                                          SizedBox(width: 4.w),
                                          Text(
                                            LocaleKeys.product_details_in_stock
                                                .tr(),
                                            style: 14.regular,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: 4.h),
                                  Text(
                                    LocaleKeys
                                        .product_details_all_prices_include_taxes
                                        .tr(),
                                    style: 13.regular.copyWith(
                                      color: AppColors.gray53,
                                    ),
                                    // style: TextStyle(
                                    //   fontSize: 13.sp,
                                    //   color: AppColors.gray53,
                                    // ),
                                  ),

                                  SizedBox(height: 8.h),
                                  Text(
                                    state.state.data?.productName ?? "",
                                    style: 18.semiBold,
                                  ),

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
                                    state.state.data?.productDescription ?? "",
                                    style: 14.regular,
                                  ),

                                  SizedBox(height: 24.h),

                                  /// INCLUDED
                                  Text(
                                    LocaleKeys.product_details_bouqet_include
                                        .tr(),
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
        },
      ),
    );
  }
}
