import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../data/models/direction_response.dart';

abstract class RouteState {
  final List<LatLng> polylinePoints;
  final RouteModel? routes;

  final String? distance;
  final String? duration;
  final bool isMoving;
  final Set<Marker> markers;
  final Set<Polyline> polylines;
  const RouteState({
    required this.polylinePoints,
    required this.routes,
    this.distance,
    this.duration,
    this.isMoving = false,
    required this.markers,
    required this.polylines,
  });
}

class RouteInitial extends RouteState {
  const RouteInitial()
    : super(
        polylinePoints: const [],
        routes: null,
        markers: const {},
        polylines: const {},
      );
}

class RouteRouteCalculated extends RouteState {
  const RouteRouteCalculated({
    required super.polylinePoints,
    required super.routes,
    required String super.distance,
    required String super.duration,
    required super.markers,
    required super.polylines,
  });
}
