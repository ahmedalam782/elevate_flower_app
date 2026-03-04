import 'dart:async';
import 'dart:developer';

import 'package:elevate_flower_app/core/utils/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({super.key});

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  final Location _location = Location();
  LatLng? _currentLocation;
  LatLngBounds? bounds;
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(30.964060450497563, 31.233796378712483),
    zoom: 19,
  );
  String? _style;
  @override
  void initState() {
    _getMapStyle(path: AppStrings.mapStyle).then((value) {
      setState(() {
        _style = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (_style == null)
        ? const SizedBox(height: 500, child: CircularProgressIndicator())
        : Expanded(
            child: Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: _kGooglePlex,
                  zoomControlsEnabled: false,
                  zoomGesturesEnabled: false,
                  markers: {
                    const Marker(
                      markerId: MarkerId("1"),
                      position: LatLng(30.966292675165427, 31.236503598613734),
                    ),
                    const Marker(
                      markerId: MarkerId("2"),
                      position: LatLng(30.96409959064242, 31.233553442716243),
                    ),
                    if (_currentLocation != null)
                      Marker(
                        markerId: const MarkerId("user"),
                        position: _currentLocation!,
                      ),
                  },

                  style: _style,
                  onMapCreated: (GoogleMapController controller) async {
                    _controller.complete(controller);
                    if (bounds == null) {
                      bounds = await zoomToFitTwoPoints(
                        controller,
                        const LatLng(30.966292675165427, 31.236503598613734),
                        const LatLng(30.96409959064242, 31.233553442716243),
                      );
                      setState(() {});
                    }
                    trackOrder();
                    // controller.animateCamera(CameraUpdate.newLatLngBounds());
                  },
                  cameraTargetBounds: CameraTargetBounds(bounds),
                ),
                Positioned(
                  left: 16,
                  top: 32,
                  child: IconButton(
                    onPressed: () {
                      context.pop();
                    },
                    icon: const Icon(Icons.arrow_back_ios),
                  ),
                ),
              ],
            ),
          );
  }

  void trackOrder() async {
    final controller = await _controller.future;
    _location.onLocationChanged.listen((event) async {
      log("location changed ===============");
      setState(() {
        _currentLocation = LatLng(event.latitude!, event.longitude!);
        controller.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(event.latitude!, event.longitude!),
              zoom: 18,
            ),
          ),
          duration: const Duration(milliseconds: 400),
        );
      });
    });
  }
}

Future<String?> _getMapStyle({required String path}) async {
  try {
    return await rootBundle.loadString(path);
  } catch (_) {
    return null;
  }
}

Future<LatLngBounds> zoomToFitTwoPoints(
  GoogleMapController controller,
  LatLng point1,
  LatLng point2,
) async {
  LatLngBounds bounds;

  if (point1.latitude > point2.latitude &&
      point1.longitude > point2.longitude) {
    bounds = LatLngBounds(southwest: point2, northeast: point1);
  } else if (point1.longitude > point2.longitude) {
    bounds = LatLngBounds(
      southwest: LatLng(point1.latitude, point2.longitude),
      northeast: LatLng(point2.latitude, point1.longitude),
    );
  } else if (point1.latitude > point2.latitude) {
    bounds = LatLngBounds(
      southwest: LatLng(point2.latitude, point1.longitude),
      northeast: LatLng(point1.latitude, point2.longitude),
    );
  } else {
    bounds = LatLngBounds(southwest: point1, northeast: point2);
  }

  CameraUpdate cameraUpdate = CameraUpdate.newLatLngBounds(bounds, 50);

  controller.animateCamera(cameraUpdate);
  return bounds;
}
