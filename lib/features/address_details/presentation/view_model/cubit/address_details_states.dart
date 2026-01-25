// ignore_for_file: public_member_api_docs, sort_constructors_first
// TODO: presentation Address_detailsStates
class AddressDetailsStates {
  bool isFetchingLocation;
  double? currentLat;
  double? currentLng;
  AddressDetailsStates({
    this.isFetchingLocation = false,
    this.currentLat,
    this.currentLng,
  });

  AddressDetailsStates copyWith({
    bool? isFetchingLocation,
    double? currentLat,
    double? currentLng,
  }) {
    return AddressDetailsStates(
      isFetchingLocation: isFetchingLocation ?? this.isFetchingLocation,
      currentLat: currentLat ?? this.currentLat,
      currentLng: currentLng ?? this.currentLng,
    );
  }
}
