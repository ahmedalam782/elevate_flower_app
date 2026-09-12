// TODO: presentation Address_detailsCubit

import 'package:elevate_flower_app/core/config/base_state/base_state.dart';
import 'package:elevate_flower_app/core/helper/location/location_helper.dart';
import 'package:elevate_flower_app/core/routes/app_router.dart';
import 'package:elevate_flower_app/features/address_details/data/models/address_details_data.dart';
import 'package:elevate_flower_app/features/address_details/data/models/cities_model.dart';
import 'package:elevate_flower_app/features/address_details/data/models/states_model.dart';
import 'package:elevate_flower_app/features/address_details/domain/use_cases/add_address_use_case.dart';
import 'package:elevate_flower_app/features/address_details/domain/use_cases/get_cities_use_case.dart';
import 'package:elevate_flower_app/features/address_details/domain/use_cases/get_states_use_case.dart';
import 'package:elevate_flower_app/features/address_details/domain/use_cases/update_address_use_case.dart';
import 'package:elevate_flower_app/features/address_details/presentation/view_model/cubit/address_details_events.dart';
import 'package:elevate_flower_app/features/address_details/presentation/view_model/cubit/address_details_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddressDetailsCubit extends Cubit<AddressDetailsStates> {
  AddressDetailsCubit({
    required this._getStatesUseCase,
    required GetCitiesUseCase getCitiesUseCase,
    required this._addAddressUseCase,
    required this._updateAddressUseCase,
  }) : _getCitiesUseCase = getCitiesUseCase,
       super(
         AddressDetailsStates(
           isFetchingLocation: false,
           fetchingLocalData: false,
           states: [],
           cities: [],
           addressDetails: AddressDetailsData(),
         ),
       );

  Future<void> doIntent(AddressDetailsEvents event) async => switch (event) {
    AdddAddressEvent() => _addAddress(),
    UpdateAddressEvent() => _updateAddress(event.id),
  };

  final GetStatesUseCase _getStatesUseCase;
  final GetCitiesUseCase _getCitiesUseCase;
  final AddAddressUseCase _addAddressUseCase;
  final UpdateAddressUseCase _updateAddressUseCase;

  final TextEditingController locationNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController recepiantNameController = TextEditingController();

  Future<void> getCurrentLocation({
    String? currentCity,
    String? stateName,
  }) async {
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
      if (currentCity != null || stateName != null) {
        filleCityAndState(
          currentCityName: currentCity,
          currentStateName: stateName,
        );
      } else {
        emit(state.copyWith(fetchingLocalData: false));
      }
    } catch (e) {
      emit(state.copyWith(isFetchingLocation: false));
    }
  }

  void filleCityAndState({String? currentCityName, String? currentStateName}) {
    CityModel? currentCity;
    StatesModel? currentState;

    for (var item in state.states) {
      if (currentStateName == item.nameEn) {
        currentState = item;
        break;
      }
    }
    for (var item in state.cities) {
      if (currentCityName == item.nameEn) {
        currentCity = item;
        break;
      }
    }
    emit(
      state.copyWith(
        selectedState: currentState,
        selectedCity: currentCity,
        fetchingLocalData: false,
      ),
    );
  }

  Future<void> _getStates() async {
    try {
      final data = await _getStatesUseCase.call();
      emit(state.copyWith(states: data));
    } catch (e) {
      // Handle error silently
    }
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

  Future<void> _addAddress() async {
    emit(state.copyWith(state: const BaseState.loading()));

    try {
      await _addAddressUseCase.call(state.addressDetails!);
      emit(state.copyWith(state: const BaseState.success(null)));
      navigatorKey.currentContext!.pop(true);
    } catch (e) {
      final error = e is Exception ? e : Exception(e.toString());
      emit(state.copyWith(state: BaseState.error(error)));
    }
  }

  Future<void> _updateAddress(String id) async {
    emit(state.copyWith(state: const BaseState.loading()));

    try {
      await _updateAddressUseCase.call(state.addressDetails!, id);
      emit(state.copyWith(state: const BaseState.success(null)));
      navigatorKey.currentContext!.pop(true);
    } catch (e) {
      final error = e is Exception ? e : Exception(e.toString());
      emit(state.copyWith(state: BaseState.error(error)));
    }
  }

  void fillState() {
    state.addressDetails = AddressDetailsData(
      city: ("${state.selectedCity?.nameEn},${state.selectedState?.nameEn}"),
      lat: state.currentLat?.toString() ?? "0.0",
      long: state.currentLng?.toString() ?? "0.0",
      street: locationNameController.text,
      phone: phoneNumberController.text,
      username: recepiantNameController.text,
    );
  }

  @override
  Future<void> close() {
    locationNameController.dispose();
    phoneNumberController.dispose();
    recepiantNameController.dispose();
    return super.close();
  }
}
