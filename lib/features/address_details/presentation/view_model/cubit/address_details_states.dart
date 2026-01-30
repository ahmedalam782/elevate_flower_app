// ignore_for_file: public_member_api_docs, sort_constructors_first
// TODO: presentation Address_detailsStates
import 'package:elevate_flower_app/core/config/base_state/base_state.dart';
import 'package:elevate_flower_app/features/address_details/data/models/address_details_data.dart';
import 'package:elevate_flower_app/features/address_details/data/models/cities_model.dart';
import 'package:elevate_flower_app/features/address_details/data/models/states_model.dart';

class AddressDetailsStates {
  bool isFetchingLocation;
  bool fetchingLocalData;
  double? currentLat;
  double? currentLng;
  AddressDetailsData? addressDetails;

  List<StatesModel> states;
  StatesModel? selectedState;

  List<CityModel> cities;
  CityModel? selectedCity;

  final BaseState? state;

  AddressDetailsStates({
    this.isFetchingLocation = false,
    required this.fetchingLocalData,
    this.currentLat,
    this.currentLng,
    this.addressDetails,
    required this.states,
    this.selectedState,
    required this.cities,
    this.selectedCity,
    this.state,
  });

  AddressDetailsStates copyWith({
    bool? isFetchingLocation,
    bool? fetchingLocalData,
    double? currentLat,
    double? currentLng,
    AddressDetailsData? addressDetails,
    List<StatesModel>? states,
    StatesModel? selectedState,
    List<CityModel>? cities,
    CityModel? selectedCity,
    BaseState? state,
  }) {
    return AddressDetailsStates(
      isFetchingLocation: isFetchingLocation ?? this.isFetchingLocation,
      fetchingLocalData: fetchingLocalData ?? this.fetchingLocalData,
      currentLat: currentLat ?? this.currentLat,
      currentLng: currentLng ?? this.currentLng,
      addressDetails: addressDetails ?? this.addressDetails,
      states: states ?? this.states,
      selectedState: selectedState ?? this.selectedState,
      cities: cities ?? this.cities,
      selectedCity: selectedCity ?? this.selectedCity,
      state: state ?? this.state,
    );
  }
}
