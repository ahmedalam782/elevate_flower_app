import 'package:elevate_flower_app/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../../helper/classes/debounce.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_icons.dart';
import 'custom_text_field.dart';

class CustomSearchWithFilter extends StatefulWidget {
  final Function(String?)? onSearchChanged;
  final VoidCallback? onFilterTap;
  final String? hintText;
  final TextEditingController? controller;
  final bool showFilter;
  final String? title;

  const CustomSearchWithFilter({
    super.key,
    this.onSearchChanged,
    this.onFilterTap,
    this.hintText,
    this.controller,
    this.showFilter = true,
    this.title,
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
    _debounce = Debounce();
    _searchController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onTextChanged);
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
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8,
          children: [
            Row(
              spacing: 8,
              children: [
                Expanded(
                  child: CustomTextField(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.grayA6,
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.primerColor,
                        width: 1,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.grayA6,
                        width: 1,
                      ),
                    ),
                    hintText: widget.title,
                    controller: _searchController,
                    onChanged: (value) {
                      _debounce.call(() {
                        widget.onSearchChanged?.call(value);
                      });
                    },
                    onFieldSubmitted: (value) =>
                        widget.onSearchChanged?.call(value),
                    textStyle: 16.light,
                    prefixIcon: AppIcons.iconsSearch,
                    suffixWidget: _hasText
                        ? GestureDetector(
                            onTap: _clearSearch,
                            child: Icon(
                              Icons.close,
                              size: 20.sp,
                              color: AppColors.grayA6,
                            ),
                          )
                        : null,
                  ),
                ),
                // Filter Button - Only visible when showFilter is true
                if (widget.showFilter) ...[
                  Gap(12.w),
                  GestureDetector(
                    onTap: widget.onFilterTap,
                    child: Container(
                      height: 48.h,
                      width: 48.w,
                      decoration: BoxDecoration(
                        color: AppColors.whiteFF,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: AppColors.grayA6.withValues(alpha: 0.3),
                          width: 1,
                        ),
                      ),
                      child: Icon(
                        Icons.filter_list_outlined,
                        color: AppColors.black0C,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ],
        );
      },
    );
  }
}
