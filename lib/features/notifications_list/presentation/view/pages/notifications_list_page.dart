import 'package:elevate_flower_app/core/config/di/injectable_config.dart';
import 'package:elevate_flower_app/features/notifications_list/presentation/view/widgets/notifications_list_body.dart';
import 'package:elevate_flower_app/features/notifications_list/presentation/view_model/cubit/notifications_list_cubit.dart';
import 'package:elevate_flower_app/features/notifications_list/presentation/view_model/cubit/notifications_list_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationsListPage extends StatelessWidget {
  NotificationsListPage({super.key});
  
  final cubit = getIt<NotificationsListCubit>();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Notification',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
      ),
      body: BlocProvider<NotificationsListCubit>(
        create: (context) =>
            cubit..doIntent(NotificationsListEvents.getNotifications()),
        child: const NotificationsListBody(),
      ),
    );
  }
}