import 'package:easy_localization/easy_localization.dart';
import 'package:elevate_flower_app/core/shared/widgets/custom_button.dart';
import 'package:elevate_flower_app/core/theme/app_colors.dart';
import 'package:elevate_flower_app/core/theme/app_typography.dart';
import 'package:elevate_flower_app/features/filter/domain/entities/filter_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../languages/locale_keys.g.dart';

enum SortOption {
  lowestPrice,
  highestPrice,
  newest,
  oldest,
  discount;

  void toApiValue() {}
}

extension SortOptionExtension on SortOption {
  FilterType toFilterType() {
    switch (this) {
      case SortOption.lowestPrice:
        return FilterType.lowestPrice;
      case SortOption.highestPrice:
        return FilterType.highestPrice;
      case SortOption.newest:
        return FilterType.newest;
      case SortOption.oldest:
        return FilterType.oldest;
      case SortOption.discount:
        return FilterType.discount;
    }
  }
}

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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Gap(24.h),

        // Title
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              LocaleKeys.products_sort_by.tr(),
              style: 20.bold.copyWith(color: AppColors.primerColor),
            ),
          ),
        ),

        Gap(20.h),

        // Sort Options
        ...SortOption.values.map((option) {
          final isSelected = _selectedSort == option;
          return InkWell(
            onTap: () {
              setState(() {
                _selectedSort = option;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.whiteFF,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black0C.withValues(alpha: 0.10),
                    blurRadius: 5.r,
                    offset: const Offset(0, 0),
                    spreadRadius: 0,
                  ),
                ],
              ),
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _getSortLabel(option),
                    style: 16.medium.copyWith(color: AppColors.black0C),
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    width: 22.w,
                    height: 22.h,
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
                              width: 12.w,
                              height: 12.h,
                              decoration: const BoxDecoration(
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

        Gap(32.h),

        // Filter Button
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: CustomButton(
            onPressed: () {
              widget.onApplyFilter?.call(_selectedSort);
              Navigator.pop(context);
            },
            title: LocaleKeys.products_filter.tr(),
            height: 52.h,
            radius: 26.r,
            leading: Icon(Icons.tune, color: AppColors.whiteFF, size: 20.sp),
          ),
        ),

        Gap(32.h),
      ],
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
    isScrollControlled: true,
    builder: (context) => FilterBottomSheet(
      selectedSort: selectedSort,
      onApplyFilter: onApplyFilter,
    ),
  );
}
