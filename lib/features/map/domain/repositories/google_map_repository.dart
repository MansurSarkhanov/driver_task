import 'package:either_dart/either.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../data/models/direction_response.dart';
import '../../data/services/google_map_service.dart';
import '../google_map_domain.dart';

final class GoogleMapRepository implements GoogleMapDomain {
  final IGoogleMapService service;

  GoogleMapRepository({required this.service});
  @override
  Future<Either<DirectionsResponse, String>> getDirections({
    required LatLng origin,
    required LatLng destination,
  }) async {
    final response = await service.getDirections(
      origin: origin,
      destination: destination,
    );
    if (response.isSuccess) {
      return Left(response.data!);
    }
    return Right(response.error!.message);
  }
}
