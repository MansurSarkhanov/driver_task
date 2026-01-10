import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class MapLocationState {
  final LatLng? currentLocation;

  final LatLng? toLatLng;
  final List<LatLng>? wayPointLatLngs;

  const MapLocationState({
    this.currentLocation,
    this.toLatLng,
    this.wayPointLatLngs,
  });
}

class LocationInitial extends MapLocationState {
  const LocationInitial({super.currentLocation});
}

class LocationPickedOnMap extends MapLocationState {
  final String fromAddress;
  final String toAddress;

  const LocationPickedOnMap({
    required this.fromAddress,
    required this.toAddress,
    required LatLng super.currentLocation,
    required super.toLatLng,
  });
}

class LocationSearchSelected extends MapLocationState {
  final String address;
  const LocationSearchSelected({
    required this.address,
    required LatLng super.currentLocation,
    required super.toLatLng,
  });
}

class LocationError extends MapLocationState {
  final String message;

  const LocationError(this.message, {super.currentLocation});
}
