import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_typography.dart';

class AnimatedTabItem extends StatefulWidget {
  final String title;
  final int tabIndex;
  final int selectedIndex;

  const AnimatedTabItem({
    super.key,
    required this.title,
    required this.tabIndex,
    required this.selectedIndex,
  });

  @override
  State<AnimatedTabItem> createState() => _AnimatedTabItemState();
}

class _AnimatedTabItemState extends State<AnimatedTabItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _borderAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _borderAnimation = Tween<double>(
      begin: 3.0,
      end: 3.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    if (widget.tabIndex == widget.selectedIndex) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(AnimatedTabItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedIndex != oldWidget.selectedIndex) {
      if (widget.tabIndex == widget.selectedIndex) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isSelected = widget.tabIndex == widget.selectedIndex;

    // Detect Arabic script to avoid unwanted line breaks on iOS.
    bool containsArabic(String s) => RegExp(r"[\u0600-\u06FF]").hasMatch(s);
    final bool isArabic = containsArabic(widget.title);
    // Replace spaces with non-breaking spaces for Arabic to keep words together.
    final String displayTitle = isArabic
        ? widget.title.replaceAll(' ', '\u00A0')
        : widget.title;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final borderColor = isSelected
            ? AppColors.primerColor
            : AppColors.grayA6;

        final textColor = isSelected
            ? AppColors.primerColor
            : Theme.of(context).brightness == Brightness.dark
            ? AppColors.grayA6
            : AppColors.grayA6;

        return Transform.scale(
          scale: _scaleAnimation.value,
          child: IntrinsicWidth(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    style: 16.regular.copyWith(color: textColor),
                    child: Text(
                      displayTitle,
                      textAlign: TextAlign.center,
                      textDirection: isArabic ? TextDirection.rtl : null,
                    ),
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  height: _borderAnimation.value,
                  padding: const EdgeInsets.only(top: 11, left: 2),
                  decoration: BoxDecoration(
                    color: borderColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(100),
                      topRight: Radius.circular(100),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
