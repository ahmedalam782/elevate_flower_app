import 'package:elevate_flower_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({
    super.key,
    required this.currentIndex,
    this.onTap,
    required this.items,
  });

  final int currentIndex;
  final List<BottomNavigationBarItem> items;
  final void Function(int value)? onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: onTap,
          items: items,
        ),
        Divider(color: AppColors.grayCF, height: 1, thickness: 1),
      ],
    );
  }
}
