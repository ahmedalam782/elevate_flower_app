import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elevate_flower_app/core/theme/app_colors.dart';
import 'package:elevate_flower_app/core/theme/app_typography.dart';
import 'package:elevate_flower_app/features/track_order/presentation/view_model/cubit/track_order_cubit.dart';
import 'package:elevate_flower_app/features/track_order/presentation/view_model/cubit/track_order_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderStep {
  final String title;
  final String dateTime;
  final bool isCompleted;
  final bool isActive;

  const OrderStep({
    required this.title,
    required this.dateTime,
    required this.isCompleted,
    this.isActive = false,
  });
}

class OrderTimeline extends StatelessWidget {
  const OrderTimeline({super.key, required this.orderId});
  final String orderId;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrackOrderCubit, TrackOrderState>(
      builder: (BuildContext context, TrackOrderState state) {
        final stepsk = getSteps(state.orderState.data ?? '', state);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(stepsk.length, (index) {
            final step = stepsk[index];
            final isLast = index == stepsk.length - 1;
            return OrderTimelineItem(
              step: step,
              isLast: isLast,
              isFirst: index == 0,
            );
          }),
        );
      },
    );
  }
}

class OrderTimelineItem extends StatelessWidget {
  final OrderStep step;
  final bool isLast;
  final bool isFirst;

  const OrderTimelineItem({
    super.key,
    required this.step,
    required this.isLast,
    required this.isFirst,
  });

  static const _lineHeight = 63.0;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Timeline column: dot + line
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!isFirst)
              Container(
                width: 2,
                color: step.isCompleted
                    ? AppColors.primerColor
                    : AppColors.gray53,
                constraints: const BoxConstraints(minHeight: (_lineHeight / 5)),
              ),

            if (isFirst) const SizedBox(height: _lineHeight / 6),
            _buildDot(),
            if (!isLast)
              Container(
                width: 2,
                color: step.isCompleted
                    ? AppColors.primerColor
                    : AppColors.gray53,
                constraints: const BoxConstraints(
                  minHeight: (_lineHeight / 1.5),
                ),
              ),
          ],
        ),
        const SizedBox(width: 16),
        // Content
        Padding(
          padding: EdgeInsets.only(bottom: isLast ? 0 : 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                step.title,
                style: 14.regular.copyWith(
                  color: step.isActive || step.isCompleted
                      ? Colors.black87
                      : Colors.black54,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                step.dateTime,
                style: 14.regular.copyWith(color: AppColors.gray53),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDot() {
    if (step.isActive) {
      // Active: filled pink circle with outer ring
      return Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.primerColor, width: 2),
        ),
        child: Center(
          child: Container(
            width: 10,
            height: 10,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primerColor,
            ),
          ),
        ),
      );
    } else if (step.isCompleted) {
      // Completed: solid pink circle
      return Container(
        width: 20,
        height: 20,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.primerColor,
        ),
      );
    } else {
      // Pending: empty grey circle
      return Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.gray53, width: 2),
          color: Colors.white,
        ),
      );
    }
  }
}
//pending, inProgress, canceled, completed

List<OrderStep> getSteps(String state, TrackOrderState trackOrderState) {
  return [
    OrderStep(
      title: 'Received your order',
      dateTime: toStringData(trackOrderState.orderDetails.data!.acceptedAt),
      isCompleted: trackOrderState.orderDetails.data!.acceptedAt != null,
      isActive: trackOrderState.orderDetails.data!.acceptedAt != null,
    ),
    OrderStep(
      title: 'Preparing your order',
      dateTime: toStringData(
        trackOrderState.orderDetails.data!.arrivedAtPickUpAt,
      ),
      isCompleted: trackOrderState.orderDetails.data!.arrivedAtPickUpAt != null,
      isActive: trackOrderState.orderDetails.data!.arrivedAtPickUpAt != null,
    ),
    OrderStep(
      title: 'Out for delivery',
      dateTime: toStringData(trackOrderState.orderDetails.data!.deliveringAt),
      isCompleted: trackOrderState.orderDetails.data!.deliveringAt != null,
      isActive: trackOrderState.orderDetails.data!.deliveringAt != null,
    ),
    OrderStep(
      title: 'Delivered',
      dateTime: toStringData(trackOrderState.orderDetails.data!.deliveredAt),
      isCompleted: trackOrderState.orderDetails.data!.deliveredAt != null,
      isActive: trackOrderState.orderDetails.data!.deliveredAt != null,
    ),
  ];
}

String toStringData(Timestamp? time) {
  if (time == null) {
    return "waitting";
  }

  final date = time.toDate();
  late String day;
  late String month;
  if (date.day < 10) {
    day = '0${date.day}';
  } else {
    day = date.day.toString();
  }
  if (date.month < 10) {
    month = '0${date.month}';
  } else {
    month = date.month.toString();
  }
  return "$day $month ${date.year} - ${date.hour}:${date.minute}";
}
