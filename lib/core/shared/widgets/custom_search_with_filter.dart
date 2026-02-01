import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../helper/classes/debounce.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_icons.dart';
import '../../theme/app_typography.dart';
import 'custom_text_field.dart';

class CustomSearchWithFilter extends StatefulWidget {
  /// Callback triggered when search text changes (with debouncing)
  final Function(String?)? onSearchChanged;

  /// Optional focus node for the search field
  final FocusNode? focusNode;

  /// Callback triggered when filter button is tapped
  final VoidCallback? onFilterTap;

  /// Callback triggered when search field is tapped (for navigation mode)
  final VoidCallback? onTap;

  /// Whether the search field is read-only (for navigation mode)
  final bool readOnly;

  /// Hint text displayed in the search field
  final String? hintText;

  final String? labelText;

  /// Optional external controller for the search field
  final TextEditingController? controller;

  /// Whether to show the filter button (default: true)
  final bool showFilter;

  /// Optional title displayed above the search field
  final String? title;

  /// Duration for debouncing search input (default: 500ms)
  final Duration debounceDuration;

  /// Custom border radius for the search field
  final double? borderRadius;

  /// Custom height for the search field
  final double? height;

  const CustomSearchWithFilter({
    super.key,
    this.onSearchChanged,
    this.onFilterTap,
    this.onTap,
    this.readOnly = false,
    this.hintText,
    this.controller,
    this.showFilter = true,
    this.title,
    this.debounceDuration = const Duration(milliseconds: 500),
    this.borderRadius,
    this.height,
    this.labelText,
    this.focusNode,
  });

  @override
  State<CustomSearchWithFilter> createState() => _CustomSearchWithFilterState();
}

class _CustomSearchWithFilterState extends State<CustomSearchWithFilter> {
  late TextEditingController _searchController;
  late Debounce _debounce;
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _searchController = widget.controller ?? TextEditingController();
    _debounce = Debounce(delay: widget.debounceDuration);
    _searchController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onTextChanged);
    // Only dispose controller if we created it internally
    if (widget.controller == null) {
      _searchController.dispose();
    }
    _debounce.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {
      _hasText = _searchController.text.isNotEmpty;
    });
  }

  void _clearSearch() {
    _searchController.clear();
    widget.onSearchChanged?.call('');
    setState(() {
      _hasText = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final borderRadiusValue = widget.borderRadius ?? 8.r;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Optional title
        if (widget.title != null && widget.title!.isNotEmpty) ...[
          Text(
            widget.title!,
            style: 16.semiBold.copyWith(
              color: isDarkMode ? AppColors.whiteFF : AppColors.black0C,
            ),
          ),
          SizedBox(height: 12.h),
        ],

        // Search field with optional filter button
        Row(
          children: [
            // Search field
            Expanded(
              child: SizedBox(
                height: widget.height ?? 48,
                child: CustomTextField(
                  maxLine: 1,
                  onTap: widget.onTap,
                  focusNode: widget.focusNode,
                  controller: _searchController,
                  isReadOnly: widget.readOnly,
                  hintText: widget.hintText,
                  labelText: widget.labelText,
                  textStyle: 14.regular,
                  prefixIcon: AppIcons.iconsSearch,
                  suffixWidget: _hasText && !widget.readOnly
                      ? GestureDetector(
                          onTap: _clearSearch,
                          child: Padding(
                            padding: EdgeInsets.all(8.w),
                            child: Icon(
                              Icons.close,
                              size: 18.sp,
                              color: AppColors.grayA6,
                            ),
                          ),
                        )
                      : null,
                  fillColor: isDarkMode ? AppColors.black0A : AppColors.whiteFF,
                  enableFill: true,
                  isDense: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(borderRadiusValue),
                    borderSide: const BorderSide(
                      color: AppColors.grayA6,
                      width: 1,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(borderRadiusValue),
                    borderSide: const BorderSide(
                      color: AppColors.grayA6,
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(borderRadiusValue),
                    borderSide: const BorderSide(
                      color: AppColors.primerColor,
                      width: 1.5,
                    ),
                  ),
                  onChanged: widget.readOnly
                      ? null
                      : (value) {
                          _debounce.call(() {
                            widget.onSearchChanged?.call(value);
                          });
                        },
                  onFieldSubmitted: widget.readOnly
                      ? null
                      : (value) {
                          widget.onSearchChanged?.call(value);
                        },
                ),
              ),
            ),

            // Filter button (optional)
            if (widget.showFilter) ...[
              const SizedBox(width: 12),
              _FilterButton(
                onTap: widget.onFilterTap,
                height: widget.height ?? 48,
                borderRadius: borderRadiusValue,
                isDarkMode: isDarkMode,
              ),
            ],
          ],
        ),
      ],
    );
  }
}

/// Filter button widget
class _FilterButton extends StatelessWidget {
  final VoidCallback? onTap;
  final double height;
  final double borderRadius;
  final bool isDarkMode;

  const _FilterButton({
    required this.onTap,
    required this.height,
    required this.borderRadius,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        height: height,
        width: height, // Make it square
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(color: AppColors.grayA6, width: 1),
        ),
        child: SvgPicture.asset(AppIcons.iconsFilter, fit: BoxFit.scaleDown),
      ),
    );
  }
}
