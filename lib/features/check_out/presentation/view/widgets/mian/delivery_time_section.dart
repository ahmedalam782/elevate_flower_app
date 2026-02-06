import 'package:easy_localization/easy_localization.dart';
import '../../../../../../core/languages/locale_keys.g.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class DelieveryTimeSection extends StatelessWidget {
  const DelieveryTimeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: AppColors.whiteF9,
      child: Column(
        spacing: 16,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                LocaleKeys.checkout_delivery_time.tr(),
                style: 18.medium.copyWith(color: AppColors.black0C),
              ),
              Text(
                LocaleKeys.checkout_schedule.tr(),
                style: 18.medium.copyWith(color: AppColors.primerColor),
              ),
            ],
          ),
          Row(
            spacing: 4,
            children: [
              const Icon(Icons.access_time, size: 24, color: AppColors.black0C),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '${LocaleKeys.checkout_instant.tr()}, ',
                      style: 14.medium.copyWith(color: AppColors.black0C),
                    ),
                    TextSpan(
                      text: '${LocaleKeys.checkout_arrive_by.tr()} 03 Sep 2024, 11:00 AM',
                      style: 14.medium.copyWith(color: AppColors.green0C),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
