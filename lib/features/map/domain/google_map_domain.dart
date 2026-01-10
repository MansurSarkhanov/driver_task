import 'package:either_dart/either.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../data/models/direction_response.dart';

abstract class GoogleMapDomain {
  Future<Either<DirectionsResponse, String>> getDirections({
    required LatLng origin,
    required LatLng destination,
  });
}
