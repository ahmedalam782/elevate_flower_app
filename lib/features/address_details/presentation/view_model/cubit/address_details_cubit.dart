// TODO: presentation Address_detailsCubit

import 'package:elevate_flower_app/core/helper/location/location_helper.dart';
import 'package:elevate_flower_app/features/address_details/data/models/cities_model.dart';
import 'package:elevate_flower_app/features/address_details/data/models/states_model.dart';
import 'package:elevate_flower_app/features/address_details/domain/use_cases/get_cities_use_case.dart';
import 'package:elevate_flower_app/features/address_details/domain/use_cases/get_states_use_case.dart';
import 'package:elevate_flower_app/features/address_details/presentation/view_model/cubit/address_details_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddressDetailsCubit extends Cubit<AddressDetailsStates> {
  AddressDetailsCubit({
    required GetStatesUseCase getStatesUseCase,
    required GetCitiesUseCase getCitiesUseCase,
  }) : _getStatesUseCase = getStatesUseCase,
       _getCitiesUseCase = getCitiesUseCase,
       super(
         AddressDetailsStates(
           isFetchingLocation: false,
           fetchingLocalData: false,
           states: [],
           cities: [],
         ),
       );
  final GetStatesUseCase _getStatesUseCase;
  final GetCitiesUseCase _getCitiesUseCase;

  final TextEditingController locationNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController recepiantNameController = TextEditingController();

  Future<void> getCurrentLocation() async {
    emit(state.copyWith(isFetchingLocation: true));
    try {
      final locationData = await LocationHelper.instance.getUserLocation();
      emit(
        state.copyWith(
          isFetchingLocation: false,
          currentLat: locationData.latitude,
          currentLng: locationData.longitude,
        ),
      );

      emit(state.copyWith(fetchingLocalData: true));
      await Future.wait([_getStates(), _getCities()]);
      emit(state.copyWith(fetchingLocalData: false));
    } catch (e) {
      emit(state.copyWith(isFetchingLocation: false));
    }
  }

  Future<void> _getStates() async {
    try {
      final data = await _getStatesUseCase.call();
      emit(state.copyWith(states: data));
      print(data);
    } catch (e) {}
  }

  Future<void> _getCities() async {
    final data = await _getCitiesUseCase.call();
    emit(state.copyWith(cities: data));
  }

  Future<void> selectState(StatesModel selectedState) async {
    emit(state.copyWith(selectedState: selectedState));
  }

  Future<void> selectCity(CityModel selectedCity) async {
    emit(state.copyWith(selectedCity: selectedCity));
  }

  @override
  Future<void> close() {
    locationNameController.dispose();
    phoneNumberController.dispose();
    recepiantNameController.dispose();
    return super.close();
  }
}
