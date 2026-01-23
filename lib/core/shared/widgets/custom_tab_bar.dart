import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../theme/app_colors.dart';
import 'animated_tab_item.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({
    super.key,
    required this.tabList,
    this.padding,
    required this.onSelectedItem,
    required this.selectedIndex,
    this.itemsPerPage,
    this.scrollController,
    this.isLoadingMore = false,
    this.isInitialLoading = false,
    this.maxItems = 20,
  });

  final List<String> tabList;
  final EdgeInsets? padding;
  final void Function(int) onSelectedItem;
  final int selectedIndex;
  final int? itemsPerPage;
  final ScrollController? scrollController;
  final bool isLoadingMore;
  final bool isInitialLoading;
  final int maxItems;

  @override
  Widget build(BuildContext context) {
    // Show shimmer tabs during initial loading
    if (isInitialLoading) {
      return _buildShimmerTabs();
    }

    final displayCount = itemsPerPage != null && itemsPerPage! > 0
        ? itemsPerPage!.clamp(0, maxItems)
        : tabList.length.clamp(0, maxItems);

    final displayList = tabList.take(displayCount).toList();

    final hasMoreItems =
        displayList.length < tabList.length && displayList.length < maxItems;

    return SizedBox(
      height: 48,
      child: ListView.separated(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 8),
        itemCount: displayList.length + (hasMoreItems && isLoadingMore ? 1 : 0),
        physics: const BouncingScrollPhysics(),
        separatorBuilder: (context, index) => const SizedBox(width: 24),
        itemBuilder: (context, index) {
          if (index == displayList.length) {
            // Show shimmer loading indicator for pagination
            return _buildShimmerTabItem();
          }

          return GestureDetector(
            onTap: () => onSelectedItem(index),
            child: AnimatedTabItem(
              title: displayList[index],
              tabIndex: index,
              selectedIndex: selectedIndex,
            ),
          );
        },
      ),
    );
  }

  Widget _buildShimmerTabs() {
    return SizedBox(
      height: 48,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 8),
        itemCount: 5, // Show 5 shimmer tabs
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (context, index) => const SizedBox(width: 24),
        itemBuilder: (context, index) {
          return _buildShimmerTabItem();
        },
      ),
    );
  }

  Widget _buildShimmerTabItem() {
    return Shimmer.fromColors(
      baseColor: AppColors.grayCF.withValues(alpha: 0.3),
      highlightColor: AppColors.whiteFF,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tab text shimmer
          Container(
            height: 35,
            width: 80,
            decoration: BoxDecoration(
              color: AppColors.whiteFF,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const SizedBox(height: 5),
          // Bottom border shimmer
          Container(
            height: 3,
            width: 80,
            decoration: const BoxDecoration(
              color: AppColors.whiteFF,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(100),
                topRight: Radius.circular(100),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
