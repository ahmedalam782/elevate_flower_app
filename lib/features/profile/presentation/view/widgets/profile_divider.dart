import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';

/// Custom divider for profile sections
class ProfileDivider extends StatelessWidget {
  final double? height;
  final double? thickness;
  final EdgeInsetsGeometry? margin;

  const ProfileDivider({super.key, this.height, this.thickness, this.margin});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 1.h,
      margin: margin ?? EdgeInsets.symmetric(horizontal: 16.w),
      color: AppColors.blackCE.withValues(alpha: 0.3),
    );
  }
}
