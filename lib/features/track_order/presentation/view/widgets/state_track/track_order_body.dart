import 'package:elevate_flower_app/core/config/base_state/base_state.dart';
import 'package:elevate_flower_app/core/errors/handle_errors/handle_errors.dart';
import 'package:elevate_flower_app/core/routes/routes.dart';
import 'package:elevate_flower_app/core/shared/widgets/custom_button.dart';
import 'package:elevate_flower_app/features/track_order/presentation/view/widgets/driver_card.dart';
import 'package:elevate_flower_app/features/track_order/presentation/view/widgets/estimated_arrival_section.dart';
import 'package:elevate_flower_app/features/track_order/presentation/view/widgets/state_track/state_progress_section.dart';
import 'package:elevate_flower_app/features/track_order/presentation/view/widgets/state_track/vehicle_image.dart';
import 'package:elevate_flower_app/features/track_order/presentation/view_model/cubit/track_order_cubit.dart';
import 'package:elevate_flower_app/features/track_order/presentation/view_model/cubit/track_order_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class TrackOrderBody extends StatelessWidget {
  const TrackOrderBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: BlocBuilder<TrackOrderCubit, TrackOrderState>(
        builder: (BuildContext context, TrackOrderState state) {
          if (state.orderDetails.state == StateType.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.orderDetails.state == StateType.error) {
            return Center(
              child: Text(
                handleError(state.orderDetails.exception) ??
                    'Something went wrong',
              ),
            );
          } else {
            return Column(
              children: [
                const EstimatedArrivalSection(time: '03 Sep 2024, 11:00 AM'),
                const Gap(40),
                DriverCard(driver: state.orderDetails.data!.driver),
                const Gap(40),
                const VehicleImage(
                  imageUrl:
                      'https://flower.elevateegy.com/uploads/3be99805-65e0-4f05-9e98-4ccfb0b2ca5f-Chopper.png',
                ),
                const Gap(40),
                OrderTimeline(orderId: state.orderDetails.data!.id),
                const Gap(40),
                CustomButton(
                  title: "Show map",
                  onPressed: () {
                    context.push(
                      Routes.trackMapOrder,
                      extra: state.orderDetails.data!.driver,
                    );
                  },
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
