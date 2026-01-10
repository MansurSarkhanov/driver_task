import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'google_map_cubit.dart';
import 'map_location_states.dart';

class MapLocationCubit extends Cubit<MapLocationState> {
  MapLocationCubit() : super(LocationInitial());
  Timer? _debounce;
  void selectAddressFromSearch({
    required String address,
    required LatLng currentLocationLatLng,
    LatLng? toLatLng,
  }) {
    emit(
      LocationSearchSelected(
        address: address,
        toLatLng: toLatLng,
        currentLocation: currentLocationLatLng,
      ),
    );
  }

  Future<void> pickAddressOnMap({
    required LatLng currentLocationLatLng,
    LatLng? toLatLng,
  }) async {
    final address = await getAddressFromCoordinates(
      currentLocationLatLng.latitude,
      currentLocationLatLng.longitude,
    );
    emit(
      LocationPickedOnMap(
        fromAddress: address,
        toAddress: address,
        toLatLng: toLatLng,
        currentLocation: currentLocationLatLng,
      ),
    );
  }

  void handleCameraIdle(
    GoogleMapController mapController,
    BuildContext context,
  ) async {
    final center = await mapController.getLatLng(
      ScreenCoordinate(
        x: (MediaQuery.of(context).size.width / 2).floor(),
        y: (MediaQuery.of(context).size.height / 2).floor(),
      ),
    );
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 250), () {
      context.read<GoogleMapCubit>().setMapMoving(true);
      context.read<MapLocationCubit>().pickAddressOnMap(
        currentLocationLatLng: center,
      );
      context.read<GoogleMapCubit>().setMapMoving(false);
    });
  }

  Future<String> getAddressFromCoordinates(
    double latitude,
    double longitude,
  ) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
      latitude,
      longitude,
    );
    Placemark placemark = placemarks.first;
    String address =
        '${placemark.street}, ${placemark.locality}, ${placemark.country}';
    return address;
  }

  void centerToCurrentLocation(GoogleMapController controller) async {
    final position = await Geolocator.getCurrentPosition();
    controller.animateCamera(
      CameraUpdate.newLatLng(LatLng(position.latitude, position.longitude)),
    );
  }
}
