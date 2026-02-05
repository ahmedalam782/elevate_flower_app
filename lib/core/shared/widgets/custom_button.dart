import 'package:easy_localization/easy_localization.dart';
import '../../languages/locale_keys.g.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_typography.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.onPressed,
    this.title,
    this.leading,
    this.backGroundColor = AppColors.primerColor,
    this.isFilled = true,
    this.borderColor = AppColors.primerColor,
    this.titleStyle,
    this.width,
    this.height,
    this.isLoading = false,
    this.elevation,
    this.radius,
    this.isExpanded = true,
    this.padding,
    this.gradient = AppColors.primerGradient,
    this.isGradient = false,
    this.hideTitle = false,
    this.icon,
  });
  final void Function()? onPressed;
  final String? title, icon;
  final Widget? leading;
  final Color? backGroundColor, borderColor;
  final bool isFilled, isLoading, isExpanded, isGradient, hideTitle;
  final double? width, height, elevation, radius;
  final TextStyle? titleStyle;
  final EdgeInsetsGeometry? padding;
  final LinearGradient? gradient;
  @override
  Widget build(BuildContext context) {
    final borderRadiusValue = radius ?? 400.r;
    final borderRadius = BorderRadius.circular(borderRadiusValue);
    final buttonWidth = isExpanded
        ? (hideTitle
              ? 50.0 // Ensure consistent animation by using double values
              : isLoading
              ? 220.0
              : width ?? 1.sw)
        : null;
    final buttonHeight = height ?? 50;
    final button = ElevatedButton(
      onPressed: isLoading ? () {} : onPressed,
      style: ElevatedButton.styleFrom(
        padding: padding,
        splashFactory: NoSplash.splashFactory,
        disabledBackgroundColor: AppColors.grayA6,
        backgroundColor: (isGradient && gradient != null) || (!isFilled)
            ? Colors.transparent
            : (isFilled ? backGroundColor : Colors.transparent),
        overlayColor: !isGradient
            ? isFilled && backGroundColor != Colors.transparent
                  ? AppColors.primerColor
                  : backGroundColor != Colors.transparent
                  ? backGroundColor
                  : borderColor
            : null,
        side: isFilled && borderColor == null
            ? null
            : BorderSide(color: borderColor ?? Colors.transparent),
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
        shadowColor: elevation != null
            ? elevation == 0
                  ? Colors.transparent
                  : AppColors.grayA6
            : null,
        elevation: elevation ?? (isFilled ? null : 0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: isExpanded ? MainAxisSize.max : MainAxisSize.min,
        spacing: 8,
        children: [
          isLoading
              ? const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: CupertinoActivityIndicator(color: AppColors.whiteF9),
                  ),
                )
              : icon != null
              ? SvgPicture.asset(
                  icon!,
                  width: 20,
                  height: 20,
                  colorFilter: ColorFilter.mode(
                    isFilled
                        ? AppColors.whiteF9
                        : backGroundColor ??
                              borderColor ??
                              AppColors.primerColor,
                    BlendMode.srcIn,
                  ),
                )
              : leading ?? const SizedBox.shrink(),

          if (title != null && !hideTitle)
            Flexible(
              child: Text(
                isLoading
                    ? LocaleKeys.custom_widgets_loading_accessibility_label.tr()
                    : title!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style:
                    titleStyle ??
                    16.semiBold.copyWith(
                      color: isFilled
                          ? AppColors.whiteF9
                          : backGroundColor ??
                                borderColor ??
                                AppColors.primerColor,
                    ),
              ),
            ),
        ],
      ),
    );
    Widget result = button;
    if (isGradient && gradient != null) {
      result = AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
        width: buttonWidth?.toDouble(),
        height: buttonHeight,
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: borderRadius,
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: borderRadius,
          child: result,
        ),
      );
    } else {
      result = AnimatedContainer(
        width: buttonWidth,
        height: buttonHeight,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOutBack,
        child: result,
      );
    }
    return Center(child: result);
  }
}
