import 'package:easy_localization/easy_localization.dart';
import 'package:elevate_flower_app/core/shared/widgets/custom_button.dart';
import 'package:elevate_flower_app/core/theme/app_colors.dart';
import 'package:elevate_flower_app/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../languages/locale_keys.g.dart';

enum SortOption { lowestPrice, highestPrice, newest, oldest, discount }

class FilterBottomSheet extends StatefulWidget {
  final SortOption? selectedSort;
  final Function(SortOption?)? onApplyFilter;

  const FilterBottomSheet({super.key, this.selectedSort, this.onApplyFilter});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  SortOption? _selectedSort;

  @override
  void initState() {
    super.initState();
    _selectedSort = widget.selectedSort;
  }

  String _getSortLabel(SortOption option) {
    switch (option) {
      case SortOption.lowestPrice:
        return LocaleKeys.products_lowest_price.tr();
      case SortOption.highestPrice:
        return LocaleKeys.products_highest_price.tr();
      case SortOption.newest:
        return LocaleKeys.products_new.tr();
      case SortOption.oldest:
        return LocaleKeys.products_old.tr();
      case SortOption.discount:
        return LocaleKeys.products_discount.tr();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteFF,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle Bar
          Container(
            margin: EdgeInsets.only(top: 12.h),
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: AppColors.grayCF,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),

          Gap(20.h),

          // Title
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                LocaleKeys.products_sort_by.tr(),
                style: 18.bold.copyWith(color: AppColors.primerColor),
              ),
            ),
          ),

          Gap(16.h),

          // Sort Options
          ...SortOption.values.map((option) {
            final isSelected = _selectedSort == option;
            return InkWell(
              onTap: () {
                setState(() {
                  _selectedSort = option;
                });
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 6.h),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                decoration: BoxDecoration(
                  color: AppColors.whiteFF,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.primerColor
                        : AppColors.grayA6.withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _getSortLabel(option),
                      style: 14.medium.copyWith(
                        color: isSelected
                            ? AppColors.primerColor
                            : AppColors.black0C,
                      ),
                    ),
                    Container(
                      width: 20.w,
                      height: 20.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected
                              ? AppColors.primerColor
                              : AppColors.grayA6,
                          width: 2,
                        ),
                      ),
                      child: isSelected
                          ? Center(
                              child: Container(
                                width: 10.w,
                                height: 10.h,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.primerColor,
                                ),
                              ),
                            )
                          : null,
                    ),
                  ],
                ),
              ),
            );
          }),

          Gap(24.h),

          // Filter Button
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: CustomButton(
              onPressed: () {
                widget.onApplyFilter?.call(_selectedSort);
                Navigator.pop(context);
              },
              title: LocaleKeys.products_filter.tr(),
              height: 48.h,
              radius: 24.r,
              leading: Icon(Icons.tune, color: AppColors.whiteFF, size: 20.sp),
            ),
          ),

          Gap(24.h),
        ],
      ),
    );
  }
}

// Helper function to show the filter bottom sheet
Future<void> showFilterBottomSheet({
  required BuildContext context,
  SortOption? selectedSort,
  Function(SortOption?)? onApplyFilter,
}) {
  return showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (context) => FilterBottomSheet(
      selectedSort: selectedSort,
      onApplyFilter: onApplyFilter,
    ),
  );
}
