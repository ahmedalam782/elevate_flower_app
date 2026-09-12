import 'package:elevate_flower_app/core/config/di/injectable_config.dart';
import 'package:elevate_flower_app/core/theme/app_colors.dart';
import 'package:elevate_flower_app/core/theme/app_typography.dart';
import 'package:elevate_flower_app/features/track_order/presentation/view/widgets/state_track/track_order_body.dart';
import 'package:elevate_flower_app/features/track_order/presentation/view_model/cubit/track_order_cubit.dart';
import 'package:elevate_flower_app/features/track_order/presentation/view_model/cubit/track_order_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class TrackOrderPage extends StatelessWidget {
  const TrackOrderPage({super.key, required this.orderId});
  final String orderId;
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<TrackOrderCubit>()
        ..doIntent(GetOrderDetailsEvent(orderId: orderId))
        ..doIntent(ListenToOrderStateEvent(orderId: orderId)),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Track Order', style: 20.medium),
          titleSpacing: 0,
          leading: InkWell(
            onTap: () {
              context.pop();
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: AppColors.black0C,
              size: 22,
            ),
          ),
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: AppColors.whiteF9,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.dark,
          ),
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(10),
            child: SizedBox(),
          ),
        ),
        body: const TrackOrderBody(),
      ),
    );
  }
}
