// ignore_for_file: public_member_api_docs, sort_constructors_first
// TODO: presentation Address_detailsStates
import 'package:elevate_flower_app/features/address_details/data/models/address_details_data.dart';

class AddressDetailsStates {
  bool isFetchingLocation;
  double? currentLat;
  double? currentLng;
  AddressDetailsData? addressDetails;
  AddressDetailsStates({
    this.isFetchingLocation = false,
    this.currentLat,
    this.currentLng,
    this.addressDetails,
  });

  AddressDetailsStates copyWith({
    bool? isFetchingLocation,
    double? currentLat,
    double? currentLng,
    AddressDetailsData? addressDetails,
  }) {
    return AddressDetailsStates(
      isFetchingLocation: isFetchingLocation ?? this.isFetchingLocation,
      currentLat: currentLat ?? this.currentLat,
      currentLng: currentLng ?? this.currentLng,
      addressDetails: addressDetails ?? this.addressDetails,
    );
  }
}
