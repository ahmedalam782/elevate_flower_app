import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/languages/locale_keys.g.dart';
import '../../../../../core/theme/app_colors.dart';

class SectionTitileAndViewAll extends StatelessWidget {
  final String title;
  final Function()? onTap;

  const SectionTitileAndViewAll({super.key, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          InkWell(
            onTap: onTap,
            child: Text(
              LocaleKeys.home_screen_view_all.tr(),
              style: const TextStyle(
                color: AppColors.primerColor,
                fontSize: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
