import 'package:elevate_flower_app/core/config/di/injectable_config.dart';
import 'package:elevate_flower_app/core/helper/classes/debounce.dart';
import 'package:elevate_flower_app/core/shared/widgets/custom_button.dart';
import 'package:elevate_flower_app/core/theme/app_animations.dart';
import 'package:elevate_flower_app/core/theme/app_images.dart';
import 'package:elevate_flower_app/features/address_details/presentation/view/widgets/address_detail_map.dart';
import 'package:elevate_flower_app/features/address_details/presentation/view_model/cubit/address_details_cubit.dart';
import 'package:elevate_flower_app/features/address_details/presentation/view_model/cubit/address_details_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart';

class AddressDetailsPage extends StatefulWidget {
  const AddressDetailsPage({super.key});

  @override
  State<AddressDetailsPage> createState() => _AddressDetailsPageState();
}

class _AddressDetailsPageState extends State<AddressDetailsPage> {
  final cubit = getIt<AddressDetailsCubit>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddressDetailsCubit>(
      create: (context) => cubit..getCurrentLocation(),
      child: Scaffold(
        body: SafeArea(
          child: BlocSelector<AddressDetailsCubit, AddressDetailsStates, bool>(
            selector: (state) {
              return state.isFetchingLocation;
            },
            builder: (context, state) {
              if (state) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [CircularProgressIndicator()],
                  ),
                );
              } else {
                if (cubit.state.currentLat == null ||
                    cubit.state.currentLng == null) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset(AppAnimations.locationNotFeched),
                        SizedBox(height: 12.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 32.w),
                          child: CustomButton(
                            onPressed: () {
                              cubit.getCurrentLocation();
                            },
                            title: "Get location",
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      children: [
                        SizedBox(height: 16.h),
                        AddressDetailMap(
                          lat: cubit.state.currentLat!,
                          lng: cubit.state.currentLng!,
                          onMapChanged: (lat, lng, locationName) {},
                        ),
                      ],
                    ),
                  );
                }
              }
            },
          ),
        ),
      ),
    );
  }
}
