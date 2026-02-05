import '../../../../../core/helper/classes/debounce.dart';
import '../../../../../core/theme/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddressDetailMap extends StatefulWidget {
  final double lat;
  final double lng;
  final Function(double lat, double lng, String locationName) onMapChanged;
  const AddressDetailMap({
    super.key,
    required this.lat,
    required this.lng,
    required this.onMapChanged,
  });

  @override
  State<AddressDetailMap> createState() => _AddressDetailMapState();
}

class _AddressDetailMapState extends State<AddressDetailMap> {
  final Debounce debounce = Debounce();
  late CameraPosition position;
  late GoogleMapController googleMapController;

  @override
  void initState() {
    position = CameraPosition(target: LatLng(widget.lat, widget.lng), zoom: 16);
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    debounce.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1.sw,
      height: 250.h,
      child: Stack(
        alignment: Alignment
            .center, // Centers all non-positioned children both vertically and horizontally

        children: [
          GoogleMap(
            initialCameraPosition: position,
            zoomControlsEnabled: false,
            onMapCreated: (controller) {
              googleMapController = controller;
            },
            onCameraMove: (position) async {
              debounce.call(() async {
                List<Placemark> placemarks = await placemarkFromCoordinates(
                  position.target.latitude,
                  position.target.longitude,
                );
                String locationName =
                    "${placemarks.first.administrativeArea}, ${placemarks.first.subAdministrativeArea}, ${placemarks.first.name}";
                widget.onMapChanged(
                  position.target.latitude,
                  position.target.longitude,
                  locationName,
                );
              });
            },
          ),
          Center(child: Image.asset(AppImages.locationMarker, width: 25.w)),
        ],
      ),
    );
  }
}
