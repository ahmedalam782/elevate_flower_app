import 'package:elevate_flower_app/features/notifications_list/presentation/view/widgets/notifications_list_bloc_builder.dart';
import 'package:flutter/material.dart';

class NotificationsListBody extends StatelessWidget {
  const NotificationsListBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: NotificationsListBlocBuilder(),
    );
  }
}