import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_typography.dart';

/// A reusable profile list item widget
class ProfileListItem extends StatelessWidget {
  final IconData? icon;
  final String? iconPath;
  final String title;
  final VoidCallback? onTap;
  final Widget? trailing;
  final Color? iconColor;

  const ProfileListItem({
    super.key,
    this.icon,
    this.iconPath,
    required this.title,
    this.onTap,
    this.trailing,
    this.iconColor,
  }) : assert(
         icon != null || iconPath != null,
         'Either icon or iconPath must be provided',
       );

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Row(
          children: [
            // Icon Container
            SizedBox(
              width: 24.w,
              height: 24.h,
              child: icon != null
                  ? Icon(
                      icon,
                      size: 20.sp,
                      color: iconColor ?? AppColors.black32,
                    )
                  : SvgPicture.asset(
                      iconPath!,
                      width: 20.w,
                      height: 20.h,
                      colorFilter: ColorFilter.mode(
                        iconColor ?? AppColors.black32,
                        BlendMode.srcIn,
                      ),
                    ),
            ),
            SizedBox(width: 12.w),
            // Title
            Expanded(
              child: Text(
                title,
                style: 14.regular.copyWith(color: AppColors.black32),
              ),
            ),
            // Trailing widget or chevron
            trailing ??
                Icon(
                  Icons.chevron_right,
                  size: 20.sp,
                  color: AppColors.black85,
                ),
          ],
        ),
      ),
    );
  }
}
