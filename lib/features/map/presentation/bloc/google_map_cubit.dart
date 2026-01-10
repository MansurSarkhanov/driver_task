import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../domain/google_map_domain.dart';
import 'google_map_states.dart';

class GoogleMapCubit extends Cubit<GoogleMapState> {
  GoogleMapCubit({required this.repository}) : super(GoogleMapInitialState());
  final GoogleMapDomain repository;

  Future<void> searchAndCalculateRoute({
    required LatLng? origin,
    required LatLng? destination,
  }) async {
    if (origin == null || destination == null) return;
    emit(GoogleMapLoadingState());
    final result = await repository.getDirections(
      origin: origin,
      destination: destination,
    );
    result.fold((direction) {
      if (direction.routes.isNotEmpty) {
        emit(GoogleMapRouteCalculatedState(directions: direction));
      } else {
        emit(GoogleMapNoResultsState());
      }
    }, (error) => emit(GoogleMapErrorState("Error")));
  }

  void setMapMoving(bool moving) {
    emit(MapMoving(moving));
  }
}
