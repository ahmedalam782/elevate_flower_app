import 'package:elevate_flower_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageDotIndicator extends StatelessWidget {
  final bool isCurrent;
  const ImageDotIndicator({super.key, required this.isCurrent});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      duration: const Duration(milliseconds: 300),
      width: 10.w,
      height: 10.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isCurrent ? AppColors.primerColor : AppColors.grayA6,
      ),
    );
  }
}
