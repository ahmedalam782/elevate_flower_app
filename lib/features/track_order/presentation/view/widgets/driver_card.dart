import 'package:elevate_flower_app/core/theme/app_colors.dart';
import 'package:elevate_flower_app/core/theme/app_images.dart';
import 'package:elevate_flower_app/core/theme/app_typography.dart';
import 'package:elevate_flower_app/features/track_order/domain/entities/track_order_entity.dart';
import 'package:elevate_flower_app/features/track_order/presentation/view/widgets/phone_button.dart';
import 'package:elevate_flower_app/features/track_order/presentation/view/widgets/whatsapp_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class DriverCard extends StatelessWidget {
  const DriverCard({super.key, required this.driver});
  final DriverEntity driver;
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
            Text('${driver.firstName} ${driver.lastName}', style: 14.medium),
            Text(
              'Is your delivery hero for today',
              style: 12.medium.copyWith(color: AppColors.gray53),
            ),
          ],
        ),
        const Gap(29),
         PhoneButton(phone: driver.phoneNumber,),
        const Gap(22),
        WhatsappButton(phone: driver.phoneNumber,),
      ],
    );
  }
}
