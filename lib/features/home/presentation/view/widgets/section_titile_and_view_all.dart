import 'package:easy_localization/easy_localization.dart';
import 'package:elevate_flower_app/core/languages/locale_keys.g.dart';
import 'package:elevate_flower_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class SectionTitileAndViewAll extends StatelessWidget {
  final String title;

  const SectionTitileAndViewAll({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            LocaleKeys.home_screen_view_all.tr(),
            style: TextStyle(color: AppColors.primerColor, fontSize: 10),
          ),
        ),
      ],
    );
  }
}
