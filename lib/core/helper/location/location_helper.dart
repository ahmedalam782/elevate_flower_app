import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart' as ph;

import 'location_exceptions.dart';

class LocationHelper {
  LocationHelper._();
  static final LocationHelper instance = LocationHelper._();

  final Location _location = Location();

  /// Main entry point → use this only
  Future<LocationData> getUserLocation() async {
    await _checkServiceEnabled();
    await _checkPermissionGranted();

    try {
      return await _location.getLocation();
    } catch (e) {
      throw LocationUnknownException(e.toString());
    }
  }

  // ------------------ PRIVATE METHODS ------------------

  Future<void> _checkServiceEnabled() async {
    bool serviceEnabled = await _location.serviceEnabled();

    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) {
        throw const LocationServiceDisabledException();
      }
    }
  }

  Future<void> _checkPermissionGranted() async {
    PermissionStatus permission = await _location.hasPermission();
    if (permission == PermissionStatus.denied) {
      permission = await _location.requestPermission();
    }

    if (permission == PermissionStatus.denied) {
      throw const PermissionNotGrantedException();
    }

    if (permission == PermissionStatus.deniedForever) {
      ph.openAppSettings();
      throw const PermissionPermanentlyDeniedException();
    }
  }
}
