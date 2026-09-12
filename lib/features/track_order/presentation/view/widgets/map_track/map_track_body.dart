import 'package:elevate_flower_app/core/shared/widgets/custom_button.dart';
import 'package:elevate_flower_app/features/track_order/domain/entities/track_order_entity.dart';
import 'package:elevate_flower_app/features/track_order/presentation/view/widgets/driver_card.dart';
import 'package:elevate_flower_app/features/track_order/presentation/view/widgets/estimated_arrival_section.dart';
import 'package:elevate_flower_app/features/track_order/presentation/view/widgets/map_track/map_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class MapTrackBody extends StatefulWidget {
  const MapTrackBody({super.key, required this.driver});
  final DriverEntity driver;
  @override
  State<MapTrackBody> createState() => _MapTrackBodyState();
}

class _MapTrackBodyState extends State<MapTrackBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const MapWidget(),
        const Gap(24),
        Padding(
          padding: const EdgeInsetsGeometry.symmetric(horizontal: 16),
          child: Column(
            children: [
              const EstimatedArrivalSection(time: "03 Sep 2024, 11:00 AM"),
              const Gap(40),
              DriverCard(driver: widget.driver),
              const Gap(40),
              CustomButton(title: "Order details", onPressed: () async {}),
              const Gap(24),
            ],
          ),
        ),
      ],
    );
  }
}
