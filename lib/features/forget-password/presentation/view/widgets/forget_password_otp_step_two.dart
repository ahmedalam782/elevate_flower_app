import 'package:easy_localization/easy_localization.dart';
import 'package:elevate_flower_app/core/languages/locale_keys.g.dart';
import 'package:elevate_flower_app/core/theme/app_colors.dart';
import 'package:elevate_flower_app/features/forget-password/presentation/view/widgets/resend_otp_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';

class ForgetPasswordOtpStepTwo extends StatelessWidget {
  const ForgetPasswordOtpStepTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 40.h),
        Align(
          alignment: AlignmentGeometry.center,
          child: Text(
            LocaleKeys.forget_password_email_verification.tr(),
            textAlign: TextAlign.center,

            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
          ),
        ),
        SizedBox(height: 16.h),
        Align(
          alignment: AlignmentGeometry.center,

          child: Text(
            LocaleKeys.forget_password_please_enter_your_code.tr(),
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14.sp, color: AppColors.gray53),
          ),
        ),
        SizedBox(height: 32.h),
        Pinput(
          length: 6,
          onCompleted: (value) {
            if (value.length == 4) {}
          },
          enabled: true,

          // errorPinTheme: ,
          focusedPinTheme: PinTheme(
            width: 50.w,
            height: 50.w,
            textStyle: TextStyle(
              fontSize: 20.sp,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),

            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(10.r),

              border: Border.all(width: 1, color: AppColors.primerColor),
            ),
          ),

          submittedPinTheme: PinTheme(
            width: 50.w,
            height: 50.w,
            textStyle: TextStyle(
              fontSize: 20.sp,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),

            decoration: BoxDecoration(
              color: AppColors.primerColor,
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(width: 1, color: AppColors.transparent),
            ),
          ),
          defaultPinTheme: PinTheme(
            width: 50.w,
            height: 50.w,
            textStyle: TextStyle(
              fontSize: 20.sp,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),

            decoration: BoxDecoration(
              color: Color(0xffE3E3E3),
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(width: 1, color: AppColors.transparent),
            ),
          ),
        ),
        SizedBox(height: 24.h),
        ResendOtpText(onResend: () {}),
      ],
    );
  }
}
