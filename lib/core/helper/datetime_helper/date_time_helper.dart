import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class DateTimeHelper {
  static String formatFullDateTimeLocalized(
    String date, {
    String? locale,
    bool withTime = true,
  }) {
    final DateTime dateTime = DateTime.parse(date).toLocal();
    final contextLocale = locale ?? 'ar';

    // Weekday and month names
    final List<String> arabicWeekdays = [
      'الاثنين',
      'الثلاثاء',
      'الأربعاء',
      'الخميس',
      'الجمعة',
      'السبت',
      'الأحد',
    ];
    final List<String> arabicMonths = [
      'يناير',
      'فبراير',
      'مارس',
      'أبريل',
      'مايو',
      'يونيو',
      'يوليو',
      'أغسطس',
      'سبتمبر',
      'أكتوبر',
      'نوفمبر',
      'ديسمبر',
    ];

    final List<String> englishWeekdays = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
    final List<String> englishMonths = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    String weekday;
    String month;
    if (contextLocale == 'ar') {
      weekday = arabicWeekdays[dateTime.weekday - 1];
      month = arabicMonths[dateTime.month - 1];
    } else {
      weekday = englishWeekdays[dateTime.weekday - 1];
      month = englishMonths[dateTime.month - 1];
    }

    final day = dateTime.day;
    final year = dateTime.year;
    final hour = dateTime.hour % 12 == 0 ? 12 : dateTime.hour % 12;
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final isAm = dateTime.hour < 12;

    String timePeriod;
    timePeriod = isAm
        ? 'date_time.a_m'.tr()
        : 'date_time.p_m'.tr();
    return withTime
        ? '$weekday، $day $month $year – ${'date_time.hour_label'.tr()} $hour:$minute $timePeriod'
        : ' $day $month $year';
  }

  static String timeAgoFromNow(String date) {
    final DateTime dateTime = DateTime.parse(date).toLocal();
    final DateTime now = DateTime.now();
    Duration diff = now.difference(dateTime);
    if (diff.isNegative) diff = Duration.zero;

    final int years = diff.inDays ~/ 365;
    final int months = (diff.inDays % 365) ~/ 30;
    final int days = (diff.inDays % 365) % 30;
    final int hours = diff.inHours % 24;

    final List<String> parts = [];
    if (years > 0) parts.add('$years ${'delivery_app.date_time.year'.tr()}');
    if (months > 0) parts.add('$months ${'delivery_app.date_time.month'.tr()}');
    if (days > 0) {
      parts.add(
        '$days ${days == 1 ? 'delivery_app.date_time.day'.tr() : 'delivery_app.date_time.days'.tr()}',
      );
    }
    if (hours > 0) {
      parts.add(
        '$hours ${hours == 1 ? 'delivery_app.date_time.hour'.tr() : 'delivery_app.date_time.hours'.tr()}',
      );
    }

    if (parts.isEmpty) return 'delivery_app.date_time.just_now'.tr();
    return '${'delivery_app.date_time.ago'.tr()} ${parts.join(' ')}';
  }

  static String reformatDateTime(String date) {
    final DateTime dateTime = DateTime.parse(date).toLocal();
    final int hour = dateTime.hour > 12
        ? dateTime.hour - 12
        : dateTime.hour == 0
        ? 12
        : dateTime.hour;
    final String period = dateTime.hour < 12
        ? 'delivery_app.date_time.am'.tr()
        : 'delivery_app.date_time.pm'.tr();

    return '${dateTime.toString().split(' ')[0].split('-').reversed.join('/')} '
        '_${hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')} $period';
  }

  static String reformatDate(String date, BuildContext context) {
    final DateTime dateTime = DateTime.parse(date).toLocal();
    final String formattedDate = DateFormat(
      'yyyy/MM/dd',
      context.locale.languageCode,
    ).format(dateTime);
    return formattedDate;
  }

  static String reformatDateLocalized(String date, {String? locale}) {
    try {
      final DateTime dateTime = DateTime.parse(date).toLocal();
      final contextLocale = locale ?? 'ar';
      final day = dateTime.day;
      final year = dateTime.year;

      final List<String> arabicMonths = [
        'يناير',
        'فبراير',
        'مارس',
        'أبريل',
        'مايو',
        'يونيو',
        'يوليو',
        'أغسطس',
        'سبتمبر',
        'أكتوبر',
        'نوفمبر',
        'ديسمبر',
      ];

      final List<String> englishShortMonths = [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec',
      ];

      if (contextLocale.startsWith('ar')) {
        final month = arabicMonths[dateTime.month - 1];
        return '$day $month $year';
      } else {
        final month = englishShortMonths[dateTime.month - 1];
        return '$day $month $year';
      }
    } catch (_) {
      // Fallback to a simple yyyy-mm-dd -> dd/mm/yyyy format if parsing fails
      try {
        final parts = date.split(' ')[0].split('-');
        if (parts.length >= 3) {
          return '${parts[2]}/${parts[1]}/${parts[0]}';
        }
      } catch (_) {}
      return date;
    }
  }

  static String reformatTimeRemaining(
    String date, {
    bool showDays = true,
    bool showHours = true,
    bool showMinutes = true,
  }) {
    final DateTime dateTime = DateTime.parse(date).toLocal();
    final DateTime now = DateTime.now();
    final Duration difference = dateTime.difference(now);
    int days = difference.inDays;
    int hours = difference.inHours.remainder(24);
    int minutes = difference.inMinutes.remainder(60);
    final List<String> parts = [];
    if (days > 0 && showDays) {
      if (hours > 0 && !showHours) {
        days += 1;
      }
      parts.add(
        "$days ${days == 1 || days == 2 ? 'date_time.day'.tr() : 'date_time.days'.tr()}",
      );
    }
    if (hours > 0 && showHours) {
      parts.add(
        "$hours ${hours == 1 || hours == 2 ? 'date_time.hour'.tr() : 'date_time.hours'.tr()}",
      );
    }
    if (minutes > 0 && showMinutes) {
      parts.add(
        "$minutes ${minutes == 1 || minutes == 2 ? 'date_time.minute'.tr() : 'date_time.minutes'.tr()}",
      );
    }
    return parts.join(' / ');
  }

  static String reformatDayRemaining(String endDate) {
    final DateTime end = DateTime.parse(endDate).toLocal();
    final DateTime now = DateTime.now();

    if (now.isAfter(end)) return '';

    final int days = end.difference(now).inDays;
    if (days <= 0) return '';

    final String dayWord = (days == 1 || days == 2)
        ? 'date_time.day'.tr()
        : 'date_time.days'.tr();
    return '(${ 'date_time.remaining'.tr()} $days $dayWord)';
  }

  static String reformatTimeLocalized(String date) {
    final DateTime dateTime = DateTime.parse(date).toLocal();

    final int hour12 = dateTime.hour % 12 == 0 ? 12 : dateTime.hour % 12;
    final String minute = dateTime.minute.toString().padLeft(2, '0');
    final bool isAm = dateTime.hour < 12;

    final String period = isAm
        ? 'date_time.a_m'.tr()
        : 'date_time.p_m'.tr();

    return '${hour12.toString().padLeft(2, '0')}:$minute $period';
  }
}
