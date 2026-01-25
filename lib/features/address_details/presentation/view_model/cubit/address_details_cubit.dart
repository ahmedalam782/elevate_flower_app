// TODO: presentation Address_detailsCubit

import 'package:elevate_flower_app/core/helper/location/location_helper.dart';
import 'package:elevate_flower_app/features/address_details/presentation/view_model/cubit/address_details_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddressDetailsCubit extends Cubit<AddressDetailsStates> {
  AddressDetailsCubit()
    : super(AddressDetailsStates(isFetchingLocation: false));

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
    } catch (e) {
      emit(state.copyWith(isFetchingLocation: false));
    }
  }
}
