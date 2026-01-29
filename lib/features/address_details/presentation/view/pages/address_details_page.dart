import 'package:easy_localization/easy_localization.dart';
import 'package:elevate_flower_app/core/config/base_state/base_state.dart';
import 'package:elevate_flower_app/core/config/di/injectable_config.dart';
import 'package:elevate_flower_app/core/helper/classes/debounce.dart';
import 'package:elevate_flower_app/core/languages/locale_keys.g.dart';
import 'package:elevate_flower_app/core/shared/widgets/custom_button.dart';
import 'package:elevate_flower_app/core/shared/widgets/custom_drop_down.dart';
import 'package:elevate_flower_app/core/shared/widgets/custom_text_field.dart';
import 'package:elevate_flower_app/core/theme/app_animations.dart';
import 'package:elevate_flower_app/core/theme/app_images.dart';
import 'package:elevate_flower_app/features/address_details/data/models/address_details_data.dart';
import 'package:elevate_flower_app/features/address_details/data/models/cities_model.dart';
import 'package:elevate_flower_app/features/address_details/data/models/states_model.dart';
import 'package:elevate_flower_app/features/address_details/presentation/view/widgets/address_detail_map.dart';
import 'package:elevate_flower_app/features/address_details/presentation/view_model/cubit/address_details_cubit.dart';
import 'package:elevate_flower_app/features/address_details/presentation/view_model/cubit/address_details_events.dart';
import 'package:elevate_flower_app/features/address_details/presentation/view_model/cubit/address_details_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart';

class AddressDetailsPage extends StatefulWidget {
  final AddressDetailsData? addressDetailsData;
  const AddressDetailsPage({super.key, this.addressDetailsData});

  @override
  State<AddressDetailsPage> createState() => _AddressDetailsPageState();
}

class _AddressDetailsPageState extends State<AddressDetailsPage> {
  final cubit = getIt<AddressDetailsCubit>();
  String? currentState;
  String? currentCity;

  @override
  void initState() {
    fillDataInCaseOfEdit();
    super.initState();
  }

  void fillDataInCaseOfEdit() {
    if (widget.addressDetailsData != null) {
      cubit.state.addressDetails = widget.addressDetailsData;
      cubit.state.currentLat = double.tryParse(
        widget.addressDetailsData?.lat ?? "",
      );
      cubit.state.currentLat = double.tryParse(
        widget.addressDetailsData?.long ?? "",
      );
      cubit.locationNameController.text =
          widget.addressDetailsData?.street ?? "";
      cubit.recepiantNameController.text =
          widget.addressDetailsData?.username ?? "";
      cubit.phoneNumberController.text = widget.addressDetailsData?.phone ?? "";

      final locationSplitted = widget.addressDetailsData?.city?.split(",");
      if (locationSplitted?.length == 2) {
        currentCity = locationSplitted![0];
        currentState = locationSplitted![1];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddressDetailsCubit>(
      create: (context) => cubit
        ..getCurrentLocation(currentCity: currentCity, stateName: currentState),
      child: Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: BlocSelector<AddressDetailsCubit, AddressDetailsStates, bool>(
              selector: (state) {
                return state.isFetchingLocation;
              },
              builder: (context, state) {
                double? oldAddressStarterLat = double.tryParse(
                  widget.addressDetailsData?.lat ?? "",
                );
                double? oldAddressStarterLng = double.tryParse(
                  widget.addressDetailsData?.long ?? "",
                );

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
                              title: LocaleKeys.address_details_get_location
                                  .tr(),
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
                            lat:
                                oldAddressStarterLat ?? cubit.state.currentLat!,
                            lng:
                                oldAddressStarterLng ?? cubit.state.currentLng!,
                            onMapChanged: (lat, lng, locationName) {
                              cubit.locationNameController.text = locationName;

                              cubit.state.addressDetails?.copyWith(
                                lat: lat.toString(),
                                lng: lng.toString(),
                                street: locationName,
                              );
                            },
                          ),
                          SizedBox(height: 24.h),
                          CustomTextField(
                            labelText: LocaleKeys.address_details_address.tr(),
                            hintText: LocaleKeys
                                .address_details_enter_your_address
                                .tr(),
                            controller: cubit.locationNameController,
                          ),
                          SizedBox(height: 24.h),
                          CustomTextField(
                            labelText: LocaleKeys.address_details_phone_number
                                .tr(),
                            hintText: LocaleKeys
                                .address_details_please_enter_phone_number
                                .tr(),
                            controller: cubit.phoneNumberController,
                          ),
                          SizedBox(height: 24.h),
                          CustomTextField(
                            labelText: LocaleKeys.address_details_rec_name.tr(),
                            hintText: LocaleKeys.address_details_enter_rec_name
                                .tr(),
                            controller: cubit.recepiantNameController,
                          ),
                          SizedBox(height: 24.h),

                          Row(
                            children: [
                              Expanded(
                                child:
                                    BlocSelector<
                                      AddressDetailsCubit,
                                      AddressDetailsStates,
                                      ({
                                        List<CityModel> cities,
                                        CityModel? city,
                                        StatesModel? state,
                                      })
                                    >(
                                      selector: (state) {
                                        return (
                                          cities: state.cities,
                                          city: state.selectedCity,
                                          state: state.selectedState,
                                        );
                                      },
                                      builder: (context, state) {
                                        List<CityModel> cities = [];
                                        if (cubit.state.selectedState == null) {
                                          cities = state.cities;
                                        } else {
                                          cubit.state.selectedCity = state
                                              .cities
                                              .firstWhere((value) {
                                                return value.id ==
                                                    cubit
                                                        .state
                                                        .selectedState
                                                        ?.governorateId;
                                              });
                                        }

                                        return AppSearchableDropdown<CityModel>(
                                          label: LocaleKeys.address_details_city
                                              .tr(),
                                          hintText: 'Cairo',
                                          value: cubit.state.selectedCity,
                                          items: cubit.state.cities,
                                          itemLabelBuilder: (e) {
                                            if (context.locale.languageCode ==
                                                "ar") {
                                              return e.nameAr ?? "";
                                            } else {
                                              return e.nameEn ?? "";
                                            }
                                          },
                                          onChanged: (v) {
                                            if (v.id !=
                                                cubit.state.selectedCity?.id) {
                                              cubit.state.selectedState = null;
                                              cubit.selectCity(v);
                                            }
                                          },

                                          // setState(() => selectedCity = v),
                                        );
                                      },
                                    ),
                              ),
                              SizedBox(width: 16.w),
                              Expanded(
                                child:
                                    BlocSelector<
                                      AddressDetailsCubit,
                                      AddressDetailsStates,
                                      ({
                                        List<StatesModel> states,
                                        StatesModel? state,
                                        CityModel? city,
                                      })
                                    >(
                                      selector: (state) {
                                        return (
                                          states: state.states,
                                          state: state.selectedState,
                                          city: state.selectedCity,
                                        );
                                      },
                                      builder: (context, state) {
                                        List<StatesModel> states = [];
                                        if (cubit.state.selectedCity == null) {
                                          states = state.states;
                                        } else {
                                          states = state.states.where((value) {
                                            return value.governorateId ==
                                                cubit.state.selectedCity?.id;
                                          }).toList();
                                        }
                                        return AppSearchableDropdown<
                                          StatesModel
                                        >(
                                          label: LocaleKeys.address_details_area
                                              .tr(),
                                          hintText: 'Cairo',
                                          value: cubit.state.selectedState,
                                          // value: "Cairo",
                                          // items: ['Cairo', 'Alexandria', 'Giza'],
                                          items: states,
                                          itemLabelBuilder: (e) {
                                            if (context.locale.languageCode ==
                                                "ar") {
                                              return e.nameAr ?? "";
                                            } else {
                                              return e.nameEn ?? "";
                                            }
                                          },
                                          onChanged: (v) => {
                                            cubit.selectState(v),
                                          },
                                          // setState(() => selectedCity = v),
                                        );
                                      },
                                    ),
                              ),
                              SizedBox(height: 16.h),
                            ],
                          ),
                          SizedBox(height: 16.w),

                          BlocSelector<
                            AddressDetailsCubit,
                            AddressDetailsStates,
                            BaseState<void>?
                          >(
                            selector: (state) {
                              return state.state;
                            },
                            builder: (context, state) {
                              return CustomButton(
                                isLoading: state == BaseState.loading(),
                                title: widget.addressDetailsData == null
                                    ? LocaleKeys.address_details_add_address
                                          .tr()
                                    : LocaleKeys.address_details_update_address
                                          .tr(),
                                onPressed: () {
                                  cubit.fillState();
                                  if (widget.addressDetailsData == null) {
                                    cubit.doIntent(AdddAddressEvent());
                                  } else {
                                    cubit.doIntent(
                                      UpdateAddressEvent(
                                        id:
                                            widget
                                                .addressDetailsData
                                                ?.addressId ??
                                            "",
                                      ),
                                    );
                                  }
                                },
                              );
                            },
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
      ),
    );
  }
}
