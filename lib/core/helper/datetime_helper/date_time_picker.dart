import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme/app_colors.dart';

Future<DateTimeRange?> pickDateRange({
  required BuildContext context,
  DateTimeRange? initialDateRange,
  DateTime? firstDate,
  DateTime? lastDate,
  Locale? locale,
  String? helpText,
  String? cancelText,
  String? confirmText,
  bool isWeb = false,
}) async {
  if (isWeb) {
    return showDialog<DateTimeRange>(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: AppColors.whiteF9,
          clipBehavior: Clip.antiAlias,
          child: SizedBox(
            width: 400.w,
            height: 600.w,
            child: DateRangePickerDialog(
              initialDateRange: initialDateRange,
              firstDate:
                  firstDate ??
                  DateTime.now().subtract(const Duration(days: 365)),
              lastDate:
                  lastDate ?? DateTime.now().add(const Duration(days: 365)),
              helpText: helpText,
              cancelText: cancelText,
              confirmText: confirmText,
              switchToInputEntryModeIcon: const Icon(
                Icons.edit_calendar_rounded,
              ),
              initialEntryMode: DatePickerEntryMode.calendarOnly,
            ),
          ),
        );
      },
    );
  } else {
    return showDateRangePicker(
      context: context,
      initialDateRange: initialDateRange,
      firstDate:
          firstDate ?? DateTime.now().subtract(const Duration(days: 365)),
      lastDate: lastDate ?? DateTime.now().add(const Duration(days: 365)),
      initialEntryMode: DatePickerEntryMode.calendar,
      locale: locale,
      helpText: helpText,
      cancelText: cancelText,
      confirmText: confirmText,
    );
  }
}
