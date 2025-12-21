import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:elevate_flower_app/core/languages/locale_keys.g.dart';
import 'package:elevate_flower_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResendOtpText extends StatefulWidget {
  final VoidCallback onResend;

  const ResendOtpText({super.key, required this.onResend});

  @override
  State<ResendOtpText> createState() => _ResendOtpTextState();
}

class _ResendOtpTextState extends State<ResendOtpText> {
  static const int _initialSeconds = 60;

  late final ValueNotifier<int> _secondsNotifier;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _secondsNotifier = ValueNotifier(_initialSeconds);
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _secondsNotifier.value = _initialSeconds;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsNotifier.value == 0) {
        timer.cancel();
      } else {
        _secondsNotifier.value--;
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _secondsNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: Theme.of(context).textTheme.bodySmall,
        children: [
          TextSpan(
            text: "${LocaleKeys.forget_password_didn_t_receive_code.tr()} ",
            style: TextStyle(color: Color(0xff0C1015), fontSize: 16.sp),
          ),

          /// 🔹 ONLY THIS PART REBUILDS
          WidgetSpan(
            alignment: PlaceholderAlignment.baseline,
            baseline: TextBaseline.alphabetic,
            child: ValueListenableBuilder<int>(
              valueListenable: _secondsNotifier,
              builder: (_, seconds, __) {
                final canResend = seconds == 0;
                final resendColor = canResend
                    ? const Color(0xffD21E6A)
                    : AppColors.black5D;

                return GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: canResend
                      ? () {
                          widget.onResend();
                          _startTimer();
                        }
                      : null,
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 0),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: resendColor, width: 1.2),
                      ),
                    ),
                    child: Text(
                      canResend ? 'Resend' : 'Resend ($seconds)',
                      style: TextStyle(
                        color: resendColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
