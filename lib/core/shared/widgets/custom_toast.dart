import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:toastification/toastification.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_typography.dart';

class CustomToast {
  final BuildContext context;
  final String? header;
  final String? description;

  ToastificationType? type;
  final bool isWeb;

  CustomToast({
    required this.context,
    this.header,
    this.description,
    this.type = ToastificationType.success,
    this.isWeb = kIsWeb,
  });

  void showToast() {
    toastification.show(
      primaryColor: type == ToastificationType.success
          ? AppColors.green0C
          : null,
      style: ToastificationStyle.fillColored,
      alignment: isWeb ? AlignmentDirectional.topEnd : Alignment.topCenter,
      type: type,
      closeOnClick: true,
      dragToClose: true,
      showProgressBar: true,
      showIcon: false,
      context: context,
      title: Text(
        header ?? "",
        style: 16.semiBold.copyWith(color: AppColors.whiteF9),
      ),
      description: description != null
          ? Text(
              description!,
              style: 16.regular.copyWith(color: AppColors.whiteF9),
            )
          : null,
      autoCloseDuration: const Duration(seconds: 5),
    );
  }

  void showAlertToast({
    String? icon,
    Color? mainColor,
    Color? backgroundColor,
    String? title,
    String? message,
  }) {
    toastification.show(
      primaryColor: backgroundColor ?? AppColors.black0C,
      style: ToastificationStyle.fillColored,
      alignment: isWeb ? AlignmentDirectional.topEnd : Alignment.topCenter,
      type: type,
      closeOnClick: false,
      dragToClose: true,
      showProgressBar: false,
      showIcon: false,
      context: context,
      applyBlurEffect: true,
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
      closeButton: const ToastCloseButton(showType: CloseButtonShowType.none),
      title: icon != null
          ? Center(
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: mainColor ?? AppColors.gray53,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: SvgPicture.asset(
                    icon,
                    width: 24,
                    height: 24,
                    colorFilter: const ColorFilter.mode(
                      AppColors.whiteF9,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            )
          : null,
      description: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 8,
        children: [
          Text(
            title ?? "",
            textAlign: TextAlign.center,
            style: 20.bold.copyWith(color: AppColors.whiteF9),
          ),
          Text(
            message ?? "",
            textAlign: TextAlign.center,
            style: 16.regular.copyWith(color: AppColors.whiteF9),
          ),
        ],
      ),
      autoCloseDuration: const Duration(seconds: 5),
    );
  }
}
