import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../languages/locale_keys.g.dart';
import '../../theme/app_icons.dart';
import '../../theme/app_typography.dart';
import 'custom_button.dart';

class NoInternetWidget extends StatelessWidget {
  const NoInternetWidget({super.key, required this.onPressed});

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(AppIcons.iconsConnectionError, height: 220),
                const SizedBox(height: 20),
                Text(LocaleKeys.global_no_internet.tr(), style: 20.semiBold),
                const SizedBox(height: 5),
                Text(
                  LocaleKeys.global_no_internet.tr(),
                  textAlign: TextAlign.center,
                  style: 18.medium,
                ),
                const SizedBox(height: 20),
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 420,
                    minWidth: 300,
                  ),
                  child: CustomButton(
                    onPressed: onPressed,
                    isGradient: false,
                    title: LocaleKeys.custom_widgets_retry_button.tr(),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
