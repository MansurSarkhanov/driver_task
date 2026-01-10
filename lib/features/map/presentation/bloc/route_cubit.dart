// trip_cubit.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_polyline_algorithm/google_polyline_algorithm.dart';

import '../../data/models/direction_response.dart';
import '../components/custom_marker.dart';
import 'route_state.dart';

class RouteCubit extends Cubit<RouteState> {
  RouteCubit() : super(RouteInitial());

  LatLngBounds buildBoundsFromPoints(List<LatLng> points) {
    double? minLat, maxLat, minLng, maxLng;
    for (final p in points) {
      if (minLat == null || p.latitude < minLat) minLat = p.latitude;
      if (maxLat == null || p.latitude > maxLat) maxLat = p.latitude;
      if (minLng == null || p.longitude < minLng) minLng = p.longitude;
      if (maxLng == null || p.longitude > maxLng) maxLng = p.longitude;
    }
    return LatLngBounds(
      southwest: LatLng(minLat ?? 0, minLng ?? 0),
      northeast: LatLng(maxLat ?? 0, maxLng ?? 0),
    );
  }

  void clearRoute() {
    emit(const RouteInitial());
  }

  Future<void> prepareAndSetRoute({
    required DirectionsResponse response,
    BitmapDescriptor? startMarker,
  }) async {
    final route = response.routes.first;
    final leg = route.legs.first;
    final decoded = decodePolyline(route.overviewPolyline.points);
    final points = decoded
        .map((e) => LatLng(e[0].toDouble(), e[1].toDouble()))
        .toList();
    final endMarker = await CustomMarker.create(text: leg.duration.text);

    final Set<Polyline> polylines = {
      Polyline(
        polylineId: const PolylineId('route'),
        points: points,
        color: Colors.black,
        width: 3,
      ),
    };

    final Set<Marker> markers = _buildMarkers(
      routes: route,
      startMarker: startMarker,
      endMarker: endMarker,
    );
    emit(
      RouteRouteCalculated(
        polylinePoints: points,
        duration: leg.duration.text,
        distance: leg.distance.text,
        routes: response.routes.first,
        markers: markers,
        polylines: polylines,
      ),
    );
  }

  Set<Marker> _buildMarkers({
    required RouteModel routes,
    BitmapDescriptor? startMarker,
    BitmapDescriptor? wayPointMarker,
    BitmapDescriptor? endMarker,
  }) {
    final Set<Marker> markers = {};

    for (int i = 0; i < routes.legs.length; i++) {
      final leg = routes.legs[i];

      markers.add(
        Marker(
          markerId: MarkerId('leg_start_$i'),
          position: LatLng(
            leg.startLocation.latitude,
            leg.startLocation.longitude,
          ),
          icon: i == 0
              ? (startMarker ?? BitmapDescriptor.defaultMarker)
              : wayPointMarker ??
                    BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueOrange,
                    ),
          infoWindow: InfoWindow(title: i == 0 ? 'Çıxış' : 'Ara Nokta $i'),
        ),
      );

      markers.add(
        Marker(
          markerId: MarkerId('leg_end_$i'),
          position: LatLng(leg.endLocation.latitude, leg.endLocation.longitude),
          icon: i == routes.legs.length - 1
              ? (endMarker ?? BitmapDescriptor.defaultMarker)
              : wayPointMarker ??
                    BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueAzure,
                    ),
          infoWindow: InfoWindow(
            title: i == routes.legs.length - 1 ? 'Varış' : 'Ara Nokta ${i + 1}',
          ),
        ),
      );
    }

    return markers;
  }
}
