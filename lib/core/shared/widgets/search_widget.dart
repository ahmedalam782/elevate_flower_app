import 'package:easy_localization/easy_localization.dart';
import 'package:elevate_flower_app/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import '../../helper/classes/debounce.dart';
import '../../helper/datetime_helper/date_time_picker.dart';
import '../../languages/locale_keys.g.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_icons.dart';
import '../../utils/constants/app_numbers.dart';
import 'custom_text_field.dart';

class SearchWidget extends StatefulWidget {
  final Function(String?)? onSearchChanged;
  final String title;
  final void Function(String? selectedValue)? onChangedStatus;
  final void Function(DateTimeRange<DateTime>? selectedRange)?
  onDateRangeSelected;
  final DateTimeRange<DateTime>? dateRange;
  final void Function(DateTimeRange<DateTime>? selectedRange)? onClearDateRange;

  const SearchWidget({
    super.key,
    this.onSearchChanged,
    required this.title,
    this.onChangedStatus,
    this.dateRange,
    this.onDateRangeSelected,
    this.onClearDateRange,
  });

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  late TextEditingController _searchController;
  late Debounce _debounce;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _debounce = Debounce();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounce.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool convertToTabletMode =
            constraints.maxWidth > (AppNumbers.kTabletMaxWidth - 1);
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
                      borderRadius: BorderRadius.circular(999),
                      borderSide: const BorderSide(
                        color: AppColors.primerColor,
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(999),
                      borderSide: const BorderSide(
                        color: AppColors.primerColor,
                        width: 1,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(999),
                      borderSide: const BorderSide(
                        color: AppColors.primerColor,
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
                  ),
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () async {
                        final DateTimeRange<DateTime>? pickedRange =
                            await pickDateRange(
                              context: context,
                              initialDateRange: widget.dateRange,
                              firstDate: DateTime.now().subtract(
                                const Duration(days: 365 * 5),
                              ),
                              lastDate: DateTime.now().add(
                                const Duration(days: 365 * 5),
                              ),
                              confirmText: LocaleKeys.custom_widgets_search
                                  .tr(),
                              isWeb: !convertToTabletMode,
                            );
                        if (pickedRange != null) {
                          widget.onDateRangeSelected?.call(pickedRange);
                        }
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        height: 44,
                        width: 44,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: AppColors.pinkF9,
                        ),
                        child: SvgPicture.asset(
                          AppIcons.iconsCalendar,
                          width: 20,
                          height: 20,
                          colorFilter: const ColorFilter.mode(
                            AppColors.primerColor,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                    if (widget.dateRange != null) ...[
                      const Gap(8),
                      InkWell(
                        onTap: () {
                          widget.onClearDateRange?.call(null);
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 10,
                          ),
                          height: 44,
                          width: 44,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: AppColors.pinkF9,
                          ),
                          child: const Icon(
                            Icons.close,
                            color: AppColors.primerColor,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
