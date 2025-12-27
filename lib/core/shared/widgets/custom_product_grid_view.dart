import 'package:elevate_flower_app/core/shared/entities/product_item_entity.dart';
import 'package:elevate_flower_app/core/shared/widgets/custom_product_item.dart';
import 'package:elevate_flower_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomProductGridView extends StatefulWidget {
  final List<ProductItemEntity> products;
  final bool isLoading;
  final bool hasMore;
  final VoidCallback? onLoadMore;
  final Function(ProductItemEntity)? onProductTap;
  final Function(ProductItemEntity)? onAddToCart;
  final int itemsPerPage;
  final ScrollController? scrollController;

  const CustomProductGridView({
    super.key,
    required this.products,
    this.isLoading = false,
    this.hasMore = false,
    this.onLoadMore,
    this.onProductTap,
    this.onAddToCart,
    this.itemsPerPage = 10,
    this.scrollController,
  });

  @override
  State<CustomProductGridView> createState() => _CustomProductGridViewState();
}

class _CustomProductGridViewState extends State<CustomProductGridView> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = widget.scrollController ?? ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    if (widget.scrollController == null) {
      _scrollController.dispose();
    }
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent * 0.8 &&
        !widget.isLoading &&
        widget.hasMore) {
      widget.onLoadMore?.call();
    }
  }

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
    // Show shimmer grid for initial loading
    if (widget.products.isEmpty && widget.isLoading) {
      return _buildShimmerGrid(context);
    }

    if (widget.products.isEmpty && !widget.isLoading) {
      return _buildEmptyWidget();
    }

    return GridView.builder(
      controller: _scrollController,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: _getCrossAxisCount(context),
        childAspectRatio: _getChildAspectRatio(context),
        crossAxisSpacing: 16.w,
        mainAxisSpacing: 16.h,
      ),
      itemCount: widget.products.length + (widget.isLoading ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == widget.products.length) {
          return Center(child: _buildLoadingIndicator());
        }

        final product = widget.products[index];
        return CustomProductItem(
          product: product,
          onTap: () => widget.onProductTap?.call(product),
          onAddToCart: () => widget.onAddToCart?.call(product),
        );
      },
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

  Widget _buildLoadingIndicator() {
    return CustomProductItem(
      product: ProductItemEntity(id: 'loading', name: 'Loading...', price: 0),
      isLoading: true,
    );
  }

  Widget _buildEmptyWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.local_florist_outlined,
            size: 80.sp,
            color: AppColors.gray7D.withValues(alpha: 0.5),
          ),
          SizedBox(height: 16.h),
          Text(
            'No products found',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.black0C,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Try adjusting your filters',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.gray7D,
            ),
          ),
        ],
      ),
    );
  }
}
