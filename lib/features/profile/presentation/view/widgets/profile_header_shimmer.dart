import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../core/theme/app_colors.dart';

/// Shimmer loading widget for profile header
class ProfileHeaderShimmer extends StatelessWidget {
  const ProfileHeaderShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 24.h),
      child: Column(
        children: [
          // Profile Image Shimmer
          Shimmer.fromColors(
            baseColor: AppColors.gray53.withValues(alpha: 0.3),
            highlightColor: AppColors.whiteFF,
            child: Container(
              width: 100.w,
              height: 100.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.gray53.withValues(alpha: 0.3),
              ),
            ),
          ),
          SizedBox(height: 12.h),

          // Name Shimmer
          Shimmer.fromColors(
            baseColor: AppColors.gray53.withValues(alpha: 0.3),
            highlightColor: AppColors.whiteFF,
            child: Container(
              width: 150.w,
              height: 20.h,
              decoration: BoxDecoration(
                color: AppColors.gray53.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
          ),
          SizedBox(height: 8.h),

          // Email Shimmer
          Shimmer.fromColors(
            baseColor: AppColors.gray53.withValues(alpha: 0.3),
            highlightColor: AppColors.whiteFF,
            child: Container(
              width: 200.w,
              height: 16.h,
              decoration: BoxDecoration(
                color: AppColors.gray53.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
