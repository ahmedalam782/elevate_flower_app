import 'package:elevate_flower_app/core/theme/app_colors.dart';
import 'package:elevate_flower_app/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class EstimatedArrivalSection extends StatelessWidget {
  const EstimatedArrivalSection({super.key, required this.time});
  final String time;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Estimated Arrival',
          style: 14.medium.copyWith(color: AppColors.gray53),
        ),
        const Gap(6),
        Text(time, style: 16.medium),
        const Gap(14),
        const Divider(color: AppColors.grayA6, height: .5),
      ],
    );
  }
}
