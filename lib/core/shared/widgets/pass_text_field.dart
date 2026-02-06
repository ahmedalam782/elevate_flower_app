import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import '../../languages/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_icons.dart';
import '../../theme/app_typography.dart';
import 'custom_text_field.dart';

class PassTextField extends StatefulWidget {
  const PassTextField({
    super.key,
    this.validator,
    this.controller,
    this.labelWidget,
    this.prefixWidget,
    this.textStyle,
    this.enableFill = true,
    this.fillColor,
    this.title,
    this.focusNode,
    this.textInputAction = TextInputAction.next,
    this.onFieldSubmitted,
    this.isReadOnly = false,
    this.inputFormatters,
    this.maxLength,
    this.textAlign,
    this.onChanged,
    this.onEditingComplete,
    this.onTap,
    this.onSaved,
    this.hintText,
    this.labelText,
    this.border,
    this.focusedBorder,
    this.enabledBorder,
    this.textDirection,
    this.disabledBorder,
    this.isDense = false,
    this.isErrorEnabled = true,
    this.autovalidateMode,
  });
  final Widget? labelWidget;
  final TextAlign? textAlign;
  final String? Function(String? value)? validator;
  final Color? fillColor;
  final bool enableFill;
  final Widget? prefixWidget;
  final TextEditingController? controller;
  final TextStyle? textStyle;
  final String? title;
  final String? hintText;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final void Function(String?)? onFieldSubmitted;
  final void Function(String?)? onSaved;
  final void Function(String?)? onChanged;
  final void Function()? onEditingComplete;
  final void Function()? onTap;
  final bool isReadOnly;
  final int? maxLength;
  final bool isDense;
  final InputBorder? border;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final InputBorder? disabledBorder;
  final TextDirection? textDirection;
  final bool isErrorEnabled;
  final String? labelText;
  final AutovalidateMode? autovalidateMode;
  @override
  State<PassTextField> createState() => _PassTextFieldState();
}

class _PassTextFieldState extends State<PassTextField> {
  bool _isPasswordVisible = false;
  FocusNode? _focusNode;
  List<bool> passwordConditionsState = [false, false, false, false, false];
  final List<String> passwordConditions = [
    LocaleKeys.validations_set_password_1_condition,
    LocaleKeys.validations_set_password_2_condition,
    LocaleKeys.validations_set_password_3_condition,
    LocaleKeys.validations_set_password_4_condition,
    LocaleKeys.validations_set_password_5_condition,
  ];

  @override
  void initState() {
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode?.addListener(() {
      _focusNode!.hasFocus ? setState(() {}) : null;
    });
    super.initState();
  }

  @override
  void dispose() {
    _focusNode?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 6,
      children: [
        CustomTextField(
          controller: widget.controller,
          validator: widget.validator,
          labelWidget: widget.labelWidget,
          prefixWidget: widget.prefixWidget,
          textStyle: widget.textStyle,
          enableFill: widget.enableFill,
          fillColor: widget.fillColor,
          title: widget.title,
          focusNode: _focusNode,
          textInputAction: widget.textInputAction,
          onFieldSubmitted: widget.onFieldSubmitted,
          isReadOnly: widget.isReadOnly,
          inputFormatters: widget.inputFormatters,
          maxLength: widget.maxLength,
          autovalidateMode: widget.autovalidateMode,
          textAlign: widget.textAlign,
          onTapOutside: (event) {
            FocusScope.of(context).unfocus();
            _focusNode!.unfocus();
          },
          onChanged: widget.isErrorEnabled
              ? _updatePasswordConditions
              : widget.onChanged,
          isErrorEnabled: widget.isErrorEnabled,
          onEditingComplete: widget.onEditingComplete,
          onTap: widget.onTap,
          onSaved: widget.onSaved,
          hintText: widget.hintText ?? LocaleKeys.custom_widgets_password.tr(),
          border: widget.border,
          focusedBorder: widget.focusedBorder,
          enabledBorder: widget.enabledBorder,
          disabledBorder: widget.disabledBorder,
          textDirection: widget.textDirection,
          isDense: widget.isDense,
          maxLine: 1,
          isObscureText: !_isPasswordVisible,
          suffixWidget: _buildToggleVisibilityButton(),
          labelText:
              widget.labelText ?? LocaleKeys.custom_widgets_password.tr(),
        ),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          switchInCurve: Curves.easeInOutBack,
          switchOutCurve: Curves.easeInOutBack,
          transitionBuilder: (child, animation) {
            return ClipRect(
              child: SizeTransition(
                sizeFactor: animation,
                axisAlignment: -1.0,
                child: child,
              ),
            );
          },
          child: widget.isErrorEnabled && _focusNode!.hasFocus
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.separated(
                      itemCount: 3,
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 500),
                            switchInCurve: Curves.easeInOut,
                            switchOutCurve: Curves.easeInOut,
                            transitionBuilder: (child, animation) {
                              return ClipRect(
                                child: SlideTransition(
                                  position:
                                      Tween<Offset>(
                                        begin: const Offset(1, 0),
                                        end: Offset.zero,
                                      ).animate(
                                        CurvedAnimation(
                                          parent: animation,
                                          curve: Curves.easeInOut,
                                        ),
                                      ),
                                  child: child,
                                ),
                              );
                            },
                            child: SvgPicture.asset(
                              passwordConditionsState[index]
                                  ? AppIcons.iconsCheckCircle
                                  : AppIcons.iconsCloseCircle,
                              key: ValueKey<bool>(
                                passwordConditionsState[index],
                              ),
                              height: 15,
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Flexible(
                            child: AnimatedDefaultTextStyle(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                              style: !passwordConditionsState[index]
                                  ? 12.regular.copyWith(color: AppColors.redCC)
                                  : 12.regular,
                              child: Text(passwordConditions[index].tr()),
                            ),
                          ),
                        ],
                      ),
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(height: 6),
                    ),
                    const SizedBox(height: 6),
                    ListView.separated(
                      itemCount: 2,
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,

                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 500),
                            switchInCurve: Curves.easeInOut,
                            switchOutCurve: Curves.easeInOut,
                            transitionBuilder: (child, animation) {
                              return ClipRect(
                                child: SlideTransition(
                                  position:
                                      Tween<Offset>(
                                        begin: const Offset(1, 0),
                                        end: Offset.zero,
                                      ).animate(
                                        CurvedAnimation(
                                          parent: animation,
                                          curve: Curves.easeInOut,
                                        ),
                                      ),
                                  child: child,
                                ),
                              );
                            },
                            child: SvgPicture.asset(
                              passwordConditionsState[index + 3]
                                  ? AppIcons.iconsCheckCircle
                                  : AppIcons.iconsCloseCircle,
                              key: ValueKey<bool>(
                                passwordConditionsState[index + 3],
                              ),
                              height: 15,
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Flexible(
                            child: AnimatedDefaultTextStyle(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                              style: !passwordConditionsState[index + 3]
                                  ? 12.regular.copyWith(color: AppColors.redCC)
                                  : 12.regular,
                              child: Text(passwordConditions[index + 3].tr()),
                            ),
                          ),
                        ],
                      ),
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(height: 6),
                    ),
                  ],
                )
              : const SizedBox(key: ValueKey('empty_password_conditions')),
        ),
      ],
    );
  }

  Widget _buildToggleVisibilityButton() {
    return IconButton(
      iconSize: 12,
      onPressed: _togglePasswordVisibility,
      icon: AnimatedSwitcher(
        duration: const Duration(milliseconds: 350),
        switchInCurve: Curves.easeInOut,
        switchOutCurve: Curves.easeInOut,
        transitionBuilder: (child, animation) => SizeTransition(
          sizeFactor: animation,
          axis: Axis.horizontal,
          axisAlignment: -1.0,
          child: child,
        ),
        child: SvgPicture.asset(
          _isPasswordVisible ? AppIcons.iconsOpenEye : AppIcons.iconsClosedEye,
          key: ValueKey<bool>(_isPasswordVisible),
          colorFilter: const ColorFilter.mode(
            AppColors.grayA6,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  void _updatePasswordConditions(String? value) {
    if (value != null && value.contains(RegExp(r'[a-z]'))) {
      passwordConditionsState[0] = true;
    } else {
      passwordConditionsState[0] = false;
    }

    if (value != null && value.contains(RegExp(r'[A-Z]'))) {
      passwordConditionsState[1] = true;
    } else {
      passwordConditionsState[1] = false;
    }

    if (value != null && value.contains(RegExp(r'[0-9]'))) {
      passwordConditionsState[2] = true;
    } else {
      passwordConditionsState[2] = false;
    }
    if (value != null && value.contains(RegExp(r'[!@#\$&*~]'))) {
      passwordConditionsState[3] = true;
    } else {
      passwordConditionsState[3] = false;
    }
    if (value != null && value.length > 8 && value.length < 30) {
      passwordConditionsState[4] = true;
    } else {
      passwordConditionsState[4] = false;
    }

    setState(() {});
  }
}
