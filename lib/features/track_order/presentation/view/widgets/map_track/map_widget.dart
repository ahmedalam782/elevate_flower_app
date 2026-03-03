import 'dart:async';

import 'package:elevate_flower_app/core/utils/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({super.key});

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(30.964060450497563, 31.233796378712483),
    zoom: 17,
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
            child: GoogleMap(
              initialCameraPosition: _kGooglePlex,
              style: _style,
              onMapCreated: (GoogleMapController controller) async {
                _controller.complete(controller);
              },
            ),
          );
  }
}

Future<String?> _getMapStyle({required String path}) async {
  try {
    return await rootBundle.loadString(path);
  } catch (_) {
    return null;
  }
}
