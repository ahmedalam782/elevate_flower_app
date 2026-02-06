import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_typography.dart';

class ResendTimer extends StatefulWidget {
  const ResendTimer({super.key, required this.onResend});
  final Function() onResend;
  @override
  ResendTimerState createState() => ResendTimerState();
}

class ResendTimerState extends State<ResendTimer> {
  int _remainingSeconds = 30;
  int _timerCount = 1;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
        } else {
          timer.cancel();
        }
      });
    });
  }

  void _handleResend() {
    setState(() {
      _remainingSeconds += 30 * _timerCount;
      _timerCount++;
    });

    if (_timer == null || !_timer!.isActive) {
      _startTimer();
    }
  }

  String _formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return "$minutes:$secs";
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'custom_widgets.code_not_received'.tr(),
          style: 14.light.copyWith(
            color: Theme.of(context).brightness == Brightness.dark
                ? AppColors.whiteF9
                : AppColors.grayA6,
          ),
        ),
        const Gap(4),
        InkWell(
          radius: 10,
          onTap: _timer == null || !_timer!.isActive
              ? () {
                  _handleResend();
                  widget.onResend();
                }
              : null,
          child: Text(
            _remainingSeconds > 0
                ? 'custom_widgets.resend_code_in'.tr(
                    args: [_formatTime(_remainingSeconds)],
                  )
                : 'custom_widgets.resend'.tr(),
            style: 14.light.copyWith(color: AppColors.primerColor),
          ),
        ),
      ],
    );
  }
}
