import 'dart:io';

import 'package:elevate_flower_app/core/theme/app_colors.dart';
import 'package:elevate_flower_app/core/theme/app_icons.dart';
import 'package:elevate_flower_app/core/theme/app_images.dart';
import 'package:elevate_flower_app/core/theme/app_typography.dart';
import 'package:elevate_flower_app/features/track_order/presentation/view/widgets/phone_button.dart';
import 'package:elevate_flower_app/features/track_order/presentation/view/widgets/whatsapp_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:url_launcher/url_launcher.dart';

class DriverCard extends StatelessWidget {
  const DriverCard({super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(AppImages.driver, width: 36, height: 36),
        const Gap(14),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Mohamed', style: 14.medium),
            Text(
              'Is your delivery hero for today',
              style: 12.medium.copyWith(color: AppColors.gray53),
            ),
          ],
        ),
        const Gap(29),
        const PhoneButton(),
        const Gap(22),
        const WhatsappButton(),
      ],
    );
  }
}




