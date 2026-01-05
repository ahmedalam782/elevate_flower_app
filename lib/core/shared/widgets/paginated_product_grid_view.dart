import 'package:easy_localization/easy_localization.dart';
import 'package:elevate_flower_app/core/shared/entities/product_item_entity.dart';
import 'package:elevate_flower_app/core/shared/widgets/custom_product_item.dart';

import 'package:elevate_flower_app/core/theme/app_colors.dart';
import 'package:elevate_flower_app/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../languages/locale_keys.g.dart';

class PaginatedProductGridView extends StatelessWidget {
  final List<ProductItemEntity> products;
  final bool isLoading;
  final int currentPage;
  final int totalPages;
  final Function(int)? onPageChanged;
  final Function(ProductItemEntity)? onProductTap;
  final Function(ProductItemEntity)? onAddToCart;

  const PaginatedProductGridView({
    super.key,
    required this.products,
    this.isLoading = false,
    this.currentPage = 1,
    this.totalPages = 1,
    this.onPageChanged,
    this.onProductTap,
    this.onAddToCart,
  });

  int _getCrossAxisCount(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (width >= 1200) {
      return 4; // Desktop - 4 columns
    } else if (width >= 900) {
      return 3; // Tablet landscape - 3 columns
    } else if (width >= 600) {
      return 2; // Tablet portrait - 2 columns
    } else {
      return 2; // Mobile - 2 columns
    }
  }

  double _getChildAspectRatio(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (width >= 1200) {
      return 0.7; // Desktop
    } else if (width >= 900) {
      return 0.68; // Tablet landscape
    } else if (width >= 600) {
      return 0.65; // Tablet portrait
    } else {
      return 0.62; // Mobile
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Grid View
        Expanded(
          child: isLoading
              ? _buildShimmerGrid(context)
              : products.isEmpty
              ? _buildEmptyWidget()
              : GridView.builder(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 16.h,
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: _getCrossAxisCount(context),
                    childAspectRatio: _getChildAspectRatio(context),
                    crossAxisSpacing: 16.w,
                    mainAxisSpacing: 16.h,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return CustomProductItem(
                      product: product,
                      onTap: () => onProductTap?.call(product),
                      onAddToCart: () => onAddToCart?.call(product),
                    );
                  },
                ),
        ),

        // Pagination Controls
        if (!isLoading && products.isNotEmpty && totalPages > 1)
          _buildPaginationControls(context),
      ],
    );
  }

  Widget _buildPaginationControls(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: AppColors.whiteFF,
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Previous Button
          _buildPageButton(
            context: context,
            icon: Icons.chevron_left,
            onPressed: currentPage > 1
                ? () => onPageChanged?.call(currentPage - 1)
                : null,
          ),

          Gap(12.w),

          // Page Numbers
          Flexible(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _buildPageNumbers(context),
              ),
            ),
          ),

          Gap(12.w),

          // Next Button
          _buildPageButton(
            context: context,
            icon: Icons.chevron_right,
            onPressed: currentPage < totalPages
                ? () => onPageChanged?.call(currentPage + 1)
                : null,
          ),
        ],
      ),
    );
  }

  List<Widget> _buildPageNumbers(BuildContext context) {
    List<Widget> pageNumbers = [];
    int startPage = 1;
    int endPage = totalPages;

    // Show max 5 page numbers at a time
    if (totalPages > 5) {
      if (currentPage <= 3) {
        endPage = 5;
      } else if (currentPage >= totalPages - 2) {
        startPage = totalPages - 4;
      } else {
        startPage = currentPage - 2;
        endPage = currentPage + 2;
      }
    }

    // First page
    if (startPage > 1) {
      pageNumbers.add(_buildPageNumberButton(context, 1));
      if (startPage > 2) {
        pageNumbers.add(_buildEllipsis());
      }
    }

    // Page range
    for (int i = startPage; i <= endPage; i++) {
      pageNumbers.add(_buildPageNumberButton(context, i));
    }

    // Last page
    if (endPage < totalPages) {
      if (endPage < totalPages - 1) {
        pageNumbers.add(_buildEllipsis());
      }
      pageNumbers.add(_buildPageNumberButton(context, totalPages));
    }

    return pageNumbers;
  }

  Widget _buildPageNumberButton(BuildContext context, int pageNumber) {
    final isActive = pageNumber == currentPage;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: InkWell(
        onTap: () => onPageChanged?.call(pageNumber),
        borderRadius: BorderRadius.circular(8.r),
        child: Container(
          width: 40.w,
          height: 40.h,
          decoration: BoxDecoration(
            color: isActive ? AppColors.primerColor : AppColors.transparent,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(
              color: isActive ? AppColors.primerColor : AppColors.grayCF,
              width: 1.5,
            ),
          ),
          child: Center(
            child: Text(
              '$pageNumber',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                color: isActive ? AppColors.whiteFF : AppColors.black0C,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEllipsis() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: SizedBox(
        width: 40.w,
        height: 40.h,
        child: Center(
          child: Text(
            '...',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.gray7D,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPageButton({
    required BuildContext context,
    required IconData icon,
    required VoidCallback? onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        width: 40.w,
        height: 40.h,
        decoration: BoxDecoration(
          color: onPressed != null
              ? AppColors.primerColor
              : AppColors.grayCF.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Icon(
          icon,
          color: onPressed != null ? AppColors.whiteFF : AppColors.gray7D,
          size: 24.sp,
        ),
      ),
    );
  }

  Widget _buildShimmerGrid(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: _getCrossAxisCount(context),
        childAspectRatio: _getChildAspectRatio(context),
        crossAxisSpacing: 16.w,
        mainAxisSpacing: 16.h,
      ),
      itemCount: 6, // Show 6 shimmer items
      itemBuilder: (context, index) {
        return CustomProductItem(
          product: ProductItemEntity(
            id: 'shimmer_$index',
            name: 'Loading...',
            price: 0,
          ),
          isLoading: true,
        );
      },
    );
  }

  Widget _buildEmptyWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.local_florist_outlined),
          const SizedBox(height: 16),
          Text(
            LocaleKeys.products_no_products.tr(),
            style: 16.medium.copyWith(color: AppColors.gray7D),
          ),
          const SizedBox(height: 8),
          Text(
            LocaleKeys.products_check_back_later.tr(),
            style: 14.regular.copyWith(color: AppColors.gray7D),
          ),
        ],
      ),
    );
  }
}
