import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:elevate_flower_app/core/theme/app_colors.dart';
import 'package:elevate_flower_app/core/theme/app_typography.dart';

/// Custom logout confirmation dialog
class LogoutConfirmationDialog extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback onConfirm;
  final String confirmText;
  final String cancelText;

  const LogoutConfirmationDialog({
    super.key,
    required this.title,
    required this.message,
    required this.onConfirm,
    this.confirmText = 'Logout',
    this.cancelText = 'Cancel',
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      child: Container(
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: AppColors.whiteFF,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title
            Text(
              title,
              style: 20.bold.copyWith(
                color: AppColors.black32,
                letterSpacing: 1.2,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12.h),
            // Message
            Text(
              message,
              style: 16.regular.copyWith(color: AppColors.black85),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),
            // Buttons
            Row(
              children: [
                // Cancel Button
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      side: BorderSide(
                        color: AppColors.black85.withValues(alpha: 0.5),
                        width: 1.5.w,
                      ),
                      backgroundColor: AppColors.whiteFF,
                    ),
                    child: Text(
                      cancelText,
                      style: 16.medium.copyWith(color: AppColors.black32),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                // Confirm Button
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      onConfirm();
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      backgroundColor: AppColors.primerColor,
                      elevation: 0,
                    ),
                    child: Text(
                      confirmText,
                      style: 16.semiBold.copyWith(color: AppColors.whiteFF),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
