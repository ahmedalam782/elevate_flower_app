import 'package:elevate_flower_app/core/theme/app_colors.dart';
import 'package:elevate_flower_app/features/track_order/domain/entities/track_order_entity.dart';
import 'package:elevate_flower_app/features/track_order/presentation/view/widgets/map_track/map_track_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TrackOrderMap extends StatelessWidget {
  const TrackOrderMap({super.key, required this.driver});
  final DriverEntity driver;
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: AppColors.whiteF9,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(body: MapTrackBody(driver: driver)),
    );
  }
}
