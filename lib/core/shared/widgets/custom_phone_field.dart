import 'package:easy_localization/easy_localization.dart' as ez;
import '../../languages/lang.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../helper/extensions/widgets_extensions.dart';
import '../../languages/locale_keys.g.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_icons.dart';
import '../../helper/phone_helper/phone_length_helper.dart';
import '../../theme/app_typography.dart';
import '../../validations/validations.dart';
import 'custom_text_field.dart';

class CustomPhoneField extends StatefulWidget {
  const CustomPhoneField({
    super.key,
    this.validator,
    this.controller,
    this.onFieldSubmitted,
    this.onChanged,
    this.onEditingComplete,
    this.onSaved,
    this.showTitle = false,
    this.initialCountryCode = '20',
    this.textInputAction = TextInputAction.next,
    this.isLocal = true,
  });
  final String? Function(String? value, int? maxLength)? validator;
  final TextEditingController? controller;
  final void Function(String? value)? onFieldSubmitted;
  final void Function(String? value)? onSaved;
  final void Function(String? value)? onChanged;
  final void Function()? onEditingComplete;
  final bool showTitle;
  final String initialCountryCode;
  final TextInputAction? textInputAction;
  final bool isLocal;

  @override
  State<CustomPhoneField> createState() => _CustomPhoneFieldState();
}

class _CustomPhoneFieldState extends State<CustomPhoneField> {
  late TextEditingController _controller;
  int? _maxLength;
  late FocusNode _focusNode;
  late FocusNode _dropdownFocusNode;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _controller.initializeCountryCode(widget.initialCountryCode);
    _focusNode = FocusNode();
    _dropdownFocusNode = FocusNode(skipTraversal: true);
    _focusNode.addListener(() {
      setState(() {});
    });
    _updateMaxLength();
  }

  void _updateMaxLength() {
    setState(() {
      _maxLength =
          PhoneHelper.countryPhoneLengths[_controller.selectedCountryCode];
    });
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.clearCountryCode();
      _controller.dispose();
    }
    _focusNode.dispose();
    _dropdownFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final countryCodes = PhoneHelper.countryPhoneLengths.keys.toList();
    return CustomTextField(
      title: widget.showTitle
          ? LocaleKeys.custom_widgets_phone_number.tr()
          : null,
      onSaved: widget.onSaved,
      textInputAction: widget.textInputAction,
      onEditingComplete: widget.onEditingComplete,
      onChanged: widget.onChanged,
      maxLength: _focusNode.hasFocus ? _maxLength : null,
      validator: (value) => Validations.validatePhoneNumber(
        value,
        _maxLength!,
        _controller.selectedCountryCode,
      ),
      focusNode: _focusNode,
      controller: _controller,
      maxLine: 1,
      textAlign: TextAlign.start,
      textInputType: TextInputType.phone,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      onFieldSubmitted: widget.onFieldSubmitted,
      hintText: LocaleKeys.custom_widgets_phone_number.tr(),
      labelText: LocaleKeys.custom_widgets_phone_number.tr(),
      suffixWidget: widget.isLocal
          ? DropdownButton<String>(
              value: _controller.selectedCountryCode,
              borderRadius: BorderRadius.circular(14),
              menuMaxHeight: 0.7.sh,
              dropdownColor: AppColors.black0C,
              menuWidth: 0.15.sw.clamp(150, 200),
              autofocus: false,
              focusNode: _dropdownFocusNode,
              padding: const EdgeInsetsDirectional.only(end: 12),
              alignment: AlignmentDirectional.centerEnd,
              elevation: 0,
              onChanged: null,
              iconSize: 0,
              underline: const SizedBox.shrink(),
              items: List.generate(countryCodes.length, (index) {
                String code = countryCodes[index];
                return DropdownMenuItem<String>(
                  value: code,
                  child: Text(
                    '+${widget.initialCountryCode}',
                    style: 16.regular,
                    textDirection: context.locale.languageCode == arabic
                        ? TextDirection.ltr
                        : TextDirection.rtl,
                  ),
                );
              }),
            )
          : DropdownButton<String>(
              value: _controller.selectedCountryCode,
              borderRadius: BorderRadius.circular(14),
              menuMaxHeight: 0.7.sh,
              dropdownColor: Theme.of(context).brightness == Brightness.dark
                  ? AppColors.black0C
                  : AppColors.whiteF9,
              menuWidth: 0.15.sw.clamp(150, 200),
              autofocus: false,
              focusNode: _dropdownFocusNode,
              padding: const EdgeInsetsDirectional.only(end: 12),
              alignment: AlignmentDirectional.centerEnd,
              elevation: 0,
              icon: Padding(
                padding: const EdgeInsetsDirectional.only(start: 5),
                child: SvgPicture.asset(
                  AppIcons.iconsDownArrow,
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).brightness == Brightness.dark
                        ? AppColors.whiteF9
                        : AppColors.black0C,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              underline: const SizedBox.shrink(),
              items: List.generate(countryCodes.length, (index) {
                String code = countryCodes[index];
                String countryName = PhoneHelper.getCountryTitle(
                  code,
                  context.locale.languageCode,
                );
                return DropdownMenuItem<String>(
                  value: code,
                  child: Text(
                    '+$countryName $code',
                    style: 12.light,
                    textDirection: context.locale.languageCode ==arabic
                        ? TextDirection.ltr
                        : TextDirection.rtl,
                  ),
                );
              }),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _controller.updateSelectedCountryCode(value);
                    _updateMaxLength();
                  });
                  if (!_focusNode.hasFocus) {
                    _focusNode.requestFocus();
                  }
                }
              },
            ),
      prefixWidget: SvgPicture.asset(
        AppIcons.iconsPhone,
        width: 20,
        height: 20,
        fit: BoxFit.scaleDown,
        colorFilter: ColorFilter.mode(
          Theme.of(context).brightness == Brightness.dark
              ? AppColors.whiteF9
              : AppColors.black0C,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
