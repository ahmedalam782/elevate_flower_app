import 'dart:async';
import 'dart:ui' as ui;

import 'package:dio/dio.dart';
import 'package:elevate_flower_app/core/config/base_state/base_state.dart';
import 'package:elevate_flower_app/core/config/di/injectable_config.dart';
import 'package:elevate_flower_app/core/errors/handle_errors/handle_errors.dart';
import 'package:elevate_flower_app/core/theme/app_images.dart';
import 'package:elevate_flower_app/core/utils/constants/app_strings.dart';
import 'package:elevate_flower_app/features/track_order/presentation/view_model/cubit/track_order_cubit.dart';
import 'package:elevate_flower_app/features/track_order/presentation/view_model/cubit/track_order_events.dart';
import 'package:elevate_flower_app/features/track_order/presentation/view_model/cubit/track_order_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({super.key});
  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  Timer? _debounce;
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor userIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor storeIcon = BitmapDescriptor.defaultMarker;
  LatLngBounds? bounds;
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  String? _style;
  @override
  void initState() {
    loadAssets().then((value) {
      setState(() {});
    });
    getIt<TrackOrderCubit>().doIntent(
      ListenToDriverLocationEvent(orderId: "6987f7c3e364ef6140518e56"),
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.future.then((value) => value.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          BlocConsumer<TrackOrderCubit, TrackOrderState>(
            bloc: getIt<TrackOrderCubit>(),
            buildWhen: (previous, current) =>
                previous.driverLocation != current.driverLocation,
            builder: (context, state) {
              if (state.driverLocation.state == StateType.error) {
                return Center(
                  child: Text(
                    handleError(state.driverLocation.exception) ??
                        'Something went wrong',
                  ),
                );
              } else if (state.orderDetails.state == StateType.success &&
                  state.driverLocation.state == StateType.success) {
                return GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                      state.orderDetails.data!.driver.location.lat.toDouble(),
                      state.orderDetails.data!.driver.location.lng.toDouble(),
                    ),
                    zoom: 17,
                  ),
                  onMapCreated: (GoogleMapController controller) async {
                    if (!_controller.isCompleted) {
                      _controller.complete(controller);
                    }
                    if (bounds == null) {
                      zoomToFitTwoPoints(
                        controller,
                        LatLng(
                          state.orderDetails.data!.store.lat.toDouble(),
                          state.orderDetails.data!.store.lng.toDouble(),
                        ),
                        const LatLng(30.966332890017576, 31.236851875863298),
                      ).then((value) {
                        bounds = value;
                        setState(() {});
                      });
                    }
                  },
                  onCameraMove: (position) =>
                      _controller.future.then((value) async {
                        _debounce?.cancel();
                        _debounce = Timer(const Duration(seconds: 2), () {
                          value.animateCamera(
                            CameraUpdate.newLatLng(
                              LatLng(
                                state.driverLocation.data!.lat.toDouble(),
                                state.driverLocation.data!.lng.toDouble(),
                              ),
                            ),

                            duration: const Duration(milliseconds: 400),
                          );
                        });
                      }),
                  zoomControlsEnabled: false,
                  zoomGesturesEnabled: true,
                  style: _style,
                  cameraTargetBounds: CameraTargetBounds(bounds),
                  markers: {
                    Marker(
                      markerId: const MarkerId("store"),
                      position: LatLng(
                        state.orderDetails.data!.store.lat.toDouble(),
                        state.orderDetails.data!.store.lng.toDouble(),
                      ),
                      infoWindow: const InfoWindow(
                        title: "Store",
                        snippet: "Store Location",
                      ),
                      icon: storeIcon,
                    ),
                    Marker(
                      markerId: const MarkerId("user"),
                      position: const LatLng(
                        30.966332890017576,
                        31.236851875863298,
                      ),
                      infoWindow: const InfoWindow(
                        title: "User",
                        snippet: "User Location",
                      ),
                      icon: userIcon,
                    ),
                    Marker(
                      markerId: const MarkerId("Driver"),
                      position: LatLng(
                        state.driverLocation.data!.lat.toDouble(),
                        state.driverLocation.data!.lng.toDouble(),
                      ),
                      icon: markerIcon,
                      infoWindow: const InfoWindow(
                        title: "Driver",
                        snippet: "Driver Location",
                      ),
                    ),
                  },
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
            listener: (BuildContext context, TrackOrderState state) async {
              final controller = await _controller.future;
              if (state.driverLocation.state == StateType.success) {
                controller.animateCamera(
                  CameraUpdate.newLatLng(
                    LatLng(
                      state.driverLocation.data!.lat.toDouble(),
                      state.driverLocation.data!.lng.toDouble(),
                    ),
                  ),
                  duration: const Duration(milliseconds: 400),
                );
              }
            },
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

  Future<void> loadAssets() async {
    await Future.wait([
      _getMapStyle(path: AppStrings.mapStyle).then((value) {
        _style = value;
      }),
      _markerFromUrl(
        "https://flower.elevateegy.com/uploads/3be99805-65e0-4f05-9e98-4ccfb0b2ca5f-Chopper.png",
      ).then((value) {
        markerIcon = value;
      }),
      _markerFromAssets(AppImages.locationMarker).then((value) {
        userIcon = value;
      }),
      _markerFromAssets(AppImages.locationMarker).then((value) {
        storeIcon = value;
      }),
    ]);
  }
}

Future<String?> _getMapStyle({required String path}) async {
  final style = await rootBundle.loadString(path);
  return style;
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

Future<BitmapDescriptor> _markerFromUrl(String url) async {
  final Response<List<int>> response = await getIt<Dio>().get<List<int>>(
    url,
    options: Options(responseType: ResponseType.bytes),
  );
  final Uint8List bytes = Uint8List.fromList(response.data!);

  final ui.Codec codec = await ui.instantiateImageCodec(
    bytes,
    targetWidth: 150, // resize
  );
  final ui.Image image = (await codec.getNextFrame()).image;
  final ByteData? byteData = await image.toByteData(
    format: ui.ImageByteFormat.png,
  );

  return BitmapDescriptor.fromBytes(byteData!.buffer.asUint8List());
}

Future<BitmapDescriptor> _markerFromAssets(String path) async {
  final ByteData bytes = await rootBundle.load(path);
  final Uint8List list = bytes.buffer.asUint8List();
  return BitmapDescriptor.fromBytes(list);
}
