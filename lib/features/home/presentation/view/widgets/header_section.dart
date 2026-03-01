import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/languages/locale_keys.g.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_images.dart';
import 'search_text_field.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Logo and Search
          Row(
            children: [
              // Logo
              Image.asset(
                AppImages.imagesIcLauncherAndroid,
                width: 30,
                height: 30,
              ),
              const SizedBox(width: 8),
              Text(
                LocaleKeys.home_screen_home_title.tr(),
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  // color: Colors.pink,
                  color: AppColors.primerColor,
                ),
              ),
              const SizedBox(width: 16),
              // Search Field
              const Expanded(child: SearchTextField(height: 40)),
            ],
          ),
          const SizedBox(height: 20),
          // Delivery Location
          Row(
            children: [
              const Icon(
                Icons.location_on_outlined,
                size: 18,
                color: AppColors.black,
              ),
              const SizedBox(width: 4),
              Text(
                LocaleKeys.home_screen_temp_location.tr(),
                style: const TextStyle(fontSize: 12, color: AppColors.black),
              ),
              const SizedBox(width: 4),
              const Icon(
                Icons.keyboard_arrow_down,
                size: 30,
                color: AppColors.primerColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
