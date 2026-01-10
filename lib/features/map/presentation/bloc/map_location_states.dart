import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class MapLocationState {
  final LatLng? currentLocation;

  final LatLng? toLatLng;

  const MapLocationState({this.currentLocation, this.toLatLng});
}

class LocationInitial extends MapLocationState {
  const LocationInitial({super.currentLocation});
}

class LocationPickedOnMap extends MapLocationState {
  const LocationPickedOnMap({
    required LatLng super.currentLocation,
    required super.toLatLng,
  });
}

class LocationError extends MapLocationState {
  final String message;

  const LocationError(this.message, {super.currentLocation});
}
