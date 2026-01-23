import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_typography.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    this.maxLine,
    this.isDense = false,
    this.validator,
    this.controller,
    this.textInputType,
    this.suffixText,
    this.suffixTextStyle,
    this.labelWidget,
    this.prefixWidget,
    this.suffixWidget,
    this.textStyle,
    this.enableFill = true,
    this.fillColor,
    this.title,
    this.isObscureText = false,
    this.focusNode,
    this.textInputAction,
    this.onFieldSubmitted,
    this.isReadOnly = false,
    this.initialValue,
    this.inputFormatters,
    this.maxLength,
    this.textAlign,
    this.onChanged,
    this.onEditingComplete,
    this.onTap,
    this.onSaved,
    this.hintText,
    this.border,
    this.focusedBorder,
    this.enabledBorder,
    this.textDirection,
    this.disabledBorder,
    this.textCapitalization,
    this.prefixIcon,
    this.isErrorEnabled = false,
    this.onTapOutside,
    this.floatingLabelBehavior,
    this.labelText,
    this.autovalidateMode,
    this.errorText,
    this.errorMaxLines,
  });
  final AutovalidateMode? autovalidateMode;
  final Widget? labelWidget;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final String? labelText;
  final TextAlign? textAlign;
  final String? Function(String? value)? validator;
  final Color? fillColor;
  final bool enableFill;
  final Widget? suffixWidget;
  final String? suffixText;
  final TextStyle? suffixTextStyle;
  final Widget? prefixWidget;
  final String? prefixIcon;
  final int? maxLine;
  final TextInputType? textInputType;
  final TextEditingController? controller;
  final TextStyle? textStyle;
  final String? title;
  final String? hintText;
  final bool isObscureText;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final String? initialValue;
  final void Function(String?)? onFieldSubmitted;
  final void Function(String?)? onSaved;
  final void Function(String?)? onChanged;
  final void Function()? onEditingComplete;
  final void Function()? onTap;
  final bool isReadOnly;
  final int? maxLength;
  final bool isDense;
  final InputBorder? border;
  final TextCapitalization? textCapitalization;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final InputBorder? disabledBorder;
  final TextDirection? textDirection;
  final bool isErrorEnabled;
  final void Function(PointerDownEvent)? onTapOutside;
  final String? errorText;
  final int? errorMaxLines;

  @override
  State<CustomTextField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextField> {
  String _animatedHintText = '';
  int _hintIndex = 0;
  bool _typingForward = true;
  Timer? _typewriterTimer;

  @override
  void initState() {
    super.initState();
    _animatedHintText = widget.hintText ?? '';
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _startTypewriterAnimation();
  }

  @override
  void dispose() {
    _typewriterTimer?.cancel();
    super.dispose();
  }

  void _startTypewriterAnimation() {
    _typewriterTimer?.cancel();
    final fullText = widget.hintText ?? '';
    const typeSpeed = Duration(milliseconds: 60);
    const pauseDuration = Duration(seconds: 5);
    _typewriterTimer = Timer.periodic(typeSpeed, (timer) {
      if (_typingForward) {
        if (_hintIndex < fullText.length) {
          setState(() {
            _hintIndex++;
            _animatedHintText = fullText.substring(0, _hintIndex);
          });
        } else {
          _typingForward = false;
          timer.cancel();
          Future.delayed(pauseDuration, () {
            if (mounted) {
              setState(() {
                _hintIndex = 0;
                _animatedHintText = '';
                _typingForward = true;
              });
              _startTypewriterAnimation();
            }
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 6,
      children: [
        if (widget.title != null && widget.title!.isNotEmpty)
          Text(widget.title ?? "", style: 14.light),
        TextFormField(
          enabled: true,
          textDirection: widget.textDirection,
          obscuringCharacter: "*",
          textCapitalization:
              widget.textCapitalization ?? TextCapitalization.none,
          onSaved: widget.onSaved,
          onEditingComplete: widget.onEditingComplete,
          onTap: widget.onTap,
          onChanged: widget.onChanged,
          onTapOutside:
              widget.onTapOutside ??
              (event) {
                FocusScope.of(context).unfocus();
              },
          autovalidateMode:
              widget.autovalidateMode ?? AutovalidateMode.onUserInteraction,
          autofocus: false,
          maxLength: widget.maxLength,
          readOnly: widget.isReadOnly,
          obscureText: widget.isObscureText,
          validator: widget.validator,
          focusNode: widget.focusNode,
          textInputAction: widget.textInputAction,
          initialValue: widget.initialValue,
          controller: widget.controller,
          maxLines: widget.maxLine,
          textAlign: widget.textAlign ?? TextAlign.start,
          keyboardType: widget.textInputType,
          inputFormatters: widget.inputFormatters,
          style: widget.textStyle ?? 16.regular,
          onFieldSubmitted: widget.onFieldSubmitted,
          errorBuilder: widget.isErrorEnabled
              ? (context, errorText) => Text(
                  errorText,
                  style: 12.regular.copyWith(color: AppColors.redCC),
                )
              : null,
          decoration: InputDecoration(
            fillColor: !widget.isReadOnly ? widget.fillColor : AppColors.grayCF,
            filled: widget.enableFill,
            isDense: widget.isDense,
            hintText: _animatedHintText.isEmpty
                ? widget.hintText
                : _animatedHintText,
            border: widget.border,
            focusedBorder: widget.focusedBorder,
            enabledBorder: widget.enabledBorder,
            disabledBorder: widget.disabledBorder,
            hintTextDirection: widget.textDirection,
            suffixIcon: widget.suffixWidget,
            suffixText: widget.suffixText,
            suffixStyle: widget.suffixTextStyle,
            prefixIcon: widget.prefixIcon != null
                ? SvgPicture.asset(
                    widget.prefixIcon!,
                    width: 24,
                    height: 24,
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).brightness == Brightness.light
                          ? AppColors.black0C
                          : AppColors.whiteF9,
                      BlendMode.srcIn,
                    ),
                    fit: BoxFit.scaleDown,
                  )
                : widget.prefixWidget,
            errorText: widget.errorText,
            errorMaxLines: widget.errorMaxLines ?? 1,
            label:
                widget.labelWidget ??
                Text(widget.labelText ?? "", style: 14.regular),
            floatingLabelBehavior:
                widget.floatingLabelBehavior ?? FloatingLabelBehavior.auto,
          ),
        ),
      ],
    );
  }
}
