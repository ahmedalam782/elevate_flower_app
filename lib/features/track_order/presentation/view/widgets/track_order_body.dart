import 'package:elevate_flower_app/core/shared/widgets/custom_button.dart';
import 'package:elevate_flower_app/features/track_order/presentation/view/widgets/driver_card.dart';
import 'package:elevate_flower_app/features/track_order/presentation/view/widgets/estimated_arrival_section.dart';
import 'package:elevate_flower_app/features/track_order/presentation/view/widgets/state_progress_section.dart';
import 'package:elevate_flower_app/features/track_order/presentation/view/widgets/vehicle_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class TrackOrderBody extends StatelessWidget {
  const TrackOrderBody({super.key});

  @override
  Widget build(BuildContext context) {
    final steps = [
      const OrderStep(
        title: 'Received your order',
        dateTime: '03 Sep 2024 - 2:10',
        isCompleted: true,
        isActive: true,
      ),
      const OrderStep(
        title: 'Preparing your order',
        dateTime: '03 Sep 2024 - 2:10',
        isCompleted: true,
        isActive: true,
      ),
      const OrderStep(
        title: 'Out for delivery',
        dateTime: '03 Sep 2024 - 2:10',
        isCompleted: true,
        isActive: true,
      ),
      const OrderStep(
        title: 'Delivered',
        dateTime: '03 Sep 2024 - 2:10',
        isCompleted: true,
      ),
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          const EstimatedArrivalSection(time: '03 Sep 2024, 11:00 AM'),
          const Gap(40),
          const DriverCard(),
          const Gap(40),
          const VehicleImage(
            imageUrl:
                'https://flower.elevateegy.com/uploads/3be99805-65e0-4f05-9e98-4ccfb0b2ca5f-Chopper.png',
          ),
          const Gap(40),
          OrderTimeline(steps: steps),
          const Gap(40),
          CustomButton(title: "Show map", onPressed: () {}),
        ],
      ),
    );
  }
}
