import 'package:elevate_flower_app/core/errors/handle_errors/handle_errors.dart';
import 'package:elevate_flower_app/core/shared/widgets/error_page.dart';
import 'package:elevate_flower_app/core/theme/app_colors.dart';
import 'package:elevate_flower_app/features/notifications_list/presentation/view/widgets/notification_item_widget.dart';
import 'package:elevate_flower_app/features/notifications_list/presentation/view_model/cubit/notifications_list_cubit.dart';
import 'package:elevate_flower_app/features/notifications_list/presentation/view_model/cubit/notifications_list_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationsListBlocBuilder extends StatelessWidget {
  const NotificationsListBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationsListCubit, NotificationsListStates>(
      buildWhen: (previous, current) =>
          previous.getNotificationsState != current.getNotificationsState,
      builder: (context, state) {
        return state.getNotificationsState.when(
          initial: () {
            return const Center(child: CircularProgressIndicator());
          },
          loading: () {
            return const Center(child: CircularProgressIndicator());
          },
          success: (notifications) {
            if (notifications.isEmpty) {
              return const Center(
                child: Text(
                  'No notifications yet',
                  style: TextStyle(fontSize: 20, color: AppColors.primerColor),
                ),
              );
            }

            return ListView.separated(
              itemCount: notifications.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return NotificationItemWidget(notification: notification);
              },
            );
          },
          error: (exception) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ErrorPage(
                message: handleError(exception),
                isScrollable: false,
              ),
            );
          },
        );
      },
    );
  }
}
