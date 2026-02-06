import 'package:easy_localization/easy_localization.dart';
import '../../../../../core/languages/locale_keys.g.dart';
import '../../../../../core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/shared/widgets/custom_pin_input.dart';
import '../../../../../core/shared/widgets/resend_timer_widget.dart';
import '../../view_model/cubit/forget_password_events.dart';
import '../../view_model/cubit/forget_password_cubit.dart';
class ForgetPasswordOtpStepTwo extends StatefulWidget {
  final ForgetPasswordCubit forgetPasswordCubit;
  const ForgetPasswordOtpStepTwo({
    super.key,
    required this.forgetPasswordCubit,
  });

  @override
  State<ForgetPasswordOtpStepTwo> createState() =>
      _ForgetPasswordOtpStepTwoState();
}

class _ForgetPasswordOtpStepTwoState extends State<ForgetPasswordOtpStepTwo> {
  String otp = "";

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
        CustomPinInput(
          length: 6,
          onCompleted: (value) {
            if (value.length == 6) {
              widget.forgetPasswordCubit.doIntent(
                VerifyOtpEvent(otp: value),
                context,
              );
            }
          },
        ),
        SizedBox(height: 24.h),
        ResendTimer(
          onResend: () {
            widget.forgetPasswordCubit.doIntent(SendOtpToEmailEvent(), context);
          },
        ),
      ],
    );
  }
}
