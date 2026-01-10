import '../../data/models/direction_response.dart';

abstract class GoogleMapState {}

class GoogleMapInitialState extends GoogleMapState {}

class GoogleMapLoadingState extends GoogleMapState {}

class GoogleMapSuccessState extends GoogleMapState {}

class GoogleMapErrorState extends GoogleMapState {
  final String error;
  GoogleMapErrorState(this.error);
}

class GoogleMapRouteCalculatedState extends GoogleMapState {
  final DirectionsResponse directions;
  GoogleMapRouteCalculatedState({required this.directions});
}

class GoogleMapNoResultsState extends GoogleMapState {}

class MapMoving extends GoogleMapState {
  final bool isMoving;
  MapMoving(this.isMoving);
}
