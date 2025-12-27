import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../theme/app_animations.dart';
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
    this.maxItems = 20,
  });
  final List<String> tabList;
  final EdgeInsets? padding;
  final void Function(int) onSelectedItem;
  final int selectedIndex;
  final int? itemsPerPage;
  final ScrollController? scrollController;
  final bool isLoadingMore;
  final int maxItems;

  @override
  Widget build(BuildContext context) {
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
        itemCount: displayList.length + (hasMoreItems ? 1 : 0),
        physics: const BouncingScrollPhysics(),
        separatorBuilder: (context, index) => const SizedBox(width: 24),
        itemBuilder: (context, index) {
          if (index == displayList.length) {
            // Show loading indicator
            return Center(
              child: Lottie.asset(
                AppAnimations.animationsLoadingAnimation,
                fit: BoxFit.scaleDown,
              ),
            );
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
}
