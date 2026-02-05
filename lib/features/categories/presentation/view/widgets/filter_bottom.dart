import 'package:easy_localization/easy_localization.dart';
import '../../../../../core/languages/locale_keys.g.dart';
import '../../../../../core/shared/widgets/filter_bottom_sheet.dart';
import '../../../../../core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class FilterBottom extends StatefulWidget {
  final SortOption? selectedSort;
  final VoidCallback onTap;

  const FilterBottom({
    super.key,
    this.selectedSort,
    required this.onTap,
  });

  @override
  State<FilterBottom> createState() => _FilterBottomState();
}

class _FilterBottomState extends State<FilterBottom> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 24,
      left: 0,
      right: 0,
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            boxShadow: [
              BoxShadow(
                color: AppColors.primerColor.withValues(alpha: 0.6),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Material(
            color: AppColors.transparent,
            child: InkWell(
              onTap: widget.onTap,
              borderRadius: BorderRadius.circular(100),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primerColor,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.tune, color: AppColors.whiteF9, size: 26),
                    const SizedBox(width: 16),
                    Text(
                      LocaleKeys.categories_category_filter_buttom_text.tr(),
                      style: const TextStyle(
                        color: AppColors.whiteF9,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}