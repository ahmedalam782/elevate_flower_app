import 'dart:async';
import 'dart:developer';

import 'package:elevate_flower_app/core/config/base_state/base_state.dart';
import 'package:elevate_flower_app/core/config/di/injectable_config.dart';
import 'package:elevate_flower_app/core/errors/handle_errors/handle_errors.dart';
import 'package:elevate_flower_app/features/track_order/presentation/view/widgets/map_track/custom_marker.dart';
import 'package:elevate_flower_app/features/track_order/presentation/view_model/cubit/track_order_cubit.dart';
import 'package:elevate_flower_app/features/track_order/presentation/view_model/cubit/track_order_events.dart';
import 'package:elevate_flower_app/features/track_order/presentation/view_model/cubit/track_order_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_marker_widgets/google_maps_marker_widgets.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({super.key});
  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  final MarkerWidgetsController _markerWidgetsController =
      MarkerWidgetsController();
  Timer? _debounce;
  LatLngBounds? bounds;
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  GoogleMapController? _mapController;

  @override
  void initState() {
    getIt<TrackOrderCubit>().doIntent(
      ListenToDriverLocationEvent(orderId: "6987f7c3e364ef6140518e56"),
    );
    super.initState();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.future.then((value) => value.dispose());
    super.dispose();
  }

  void _addMarkers(TrackOrderState state) {
    const storeMarkerId = MarkerId('storeMarker');
    _markerWidgetsController.addMarkerWidget(
      markerWidget: MarkerWidget(
        markerId: storeMarkerId,
        child: CustomMarker(label: state.orderDetails.data!.store.name),
      ),
      marker: Marker(
        markerId: storeMarkerId,
        anchor: const Offset(0.5, 0.5),
        position: LatLng(
          state.orderDetails.data!.store.lat,
          state.orderDetails.data!.store.lng,
        ),
      ),
    );
    const driverMarkerId = MarkerId('driverMarker');
    _markerWidgetsController.addMarkerWidget(
      markerWidget: const MarkerWidget(
        markerId: driverMarkerId,
        child: DriverMarker(
          imageUrl:
              "https://flower.elevateegy.com/uploads/3be99805-65e0-4f05-9e98-4ccfb0b2ca5f-Chopper.png",
        ),
      ),
      marker: Marker(
        markerId: driverMarkerId,
        position: LatLng(
          state.orderDetails.data!.driver.location.lat,
          state.orderDetails.data!.driver.location.lng,
        ),
        anchor: const Offset(0.5, 0.5),
      ),
    );
    const userMarkerId = MarkerId('user');
    _markerWidgetsController.addMarkerWidget(
      markerWidget: const MarkerWidget(
        markerId: userMarkerId,
        child: CustomMarker(label: "Delivery Location"),
      ),
      marker: const Marker(
        markerId: userMarkerId,
        anchor: Offset(0.5, 0.5),
        position: LatLng(30.966332890017576, 31.236851875863298),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          BlocConsumer<TrackOrderCubit, TrackOrderState>(
            bloc: getIt<TrackOrderCubit>(),
            buildWhen: (previous, current) =>
                (previous.driverLocation.state !=
                    current.driverLocation.state ||
                previous.driverLocation.data != current.driverLocation.data),
            builder: (_, state) {
              if (state.driverLocation.state == StateType.loading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state.driverLocation.state == StateType.error) {
                return Center(
                  child: Text(
                    handleError(state.driverLocation.exception) ??
                        "Some thing went wrong",
                  ),
                );
              } else if (state.driverLocation.state == StateType.success) {
                return MarkerWidgets(
                  markerWidgetsController: _markerWidgetsController,
                  builder: (BuildContext context, Set<Marker> markers) {
                    return GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: LatLng(
                          state.orderDetails.data!.driver.location.lat,
                          state.orderDetails.data!.driver.location.lng,
                        ),
                        zoom: 17,
                      ),
                      onMapCreated: (c) async {
                        _mapController = c;

                        if (!_controller.isCompleted) {
                          _controller.complete(c);
                        }
                        if (bounds == null) {
                          zoomToFitTwoPoints(
                            c,
                            LatLng(
                              state.orderDetails.data!.store.lat,
                              state.orderDetails.data!.store.lng,
                            ),
                            const LatLng(
                              30.966332890017576,
                              31.236851875863298,
                            ),
                          ).then((value) {
                            bounds = value;
                            setState(() {});
                          });
                        }
                      },
                      onCameraMove: (_) {
                        if (!mounted) return;
                        _controller.future.then((value) async {
                          _debounce?.cancel();
                          _debounce = Timer(const Duration(seconds: 2), () {
                            log(
                              "lat on camera move: ${state.driverLocation.data!.lat}",
                            );
                            log(
                              "lng on camera move: ${state.driverLocation.data!.lng}",
                            );
                            value.animateCamera(
                              CameraUpdate.newLatLng(
                                LatLng(
                                  state.driverLocation.data!.lat,
                                  state.driverLocation.data!.lng,
                                ),
                              ),

                              duration: const Duration(milliseconds: 400),
                            );
                          });
                        });
                      },
                      zoomControlsEnabled: false,
                      zoomGesturesEnabled: true,
                      style: getIt<TrackOrderCubit>().style,
                      cameraTargetBounds: CameraTargetBounds(bounds),
                      markers: markers,
                    );
                  },
                );
              } else {
                return const SizedBox();
              }
            },
            listener: (BuildContext context, TrackOrderState state) async {
              if (_markerWidgetsController.markers.value.isEmpty) {
                _addMarkers(state);
              }
              if (state.driverLocation.state == StateType.success) {
                final marker = _markerWidgetsController.markerForId(
                  const MarkerId('driverMarker'),
                )!;
                final newPosition = LatLng(
                  state.driverLocation.data!.lat,
                  state.driverLocation.data!.lng,
                );
                final updatedMarker = marker.copyWith(
                  positionParam: newPosition,
                );
                _markerWidgetsController.updateMarker(
                  updatedMarker,
                  duration: const Duration(milliseconds: 400),
                );

                if (_mapController != null) {
                  _mapController!.animateCamera(
                    CameraUpdate.newLatLng(
                      LatLng(
                        state.driverLocation.data!.lat,
                        state.driverLocation.data!.lng,
                      ),
                    ),
                    duration: const Duration(milliseconds: 400),
                  );
                }
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
}
