import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DirectionsResponse extends Equatable {
  // final List<GeocodedWaypoint> geocodedWaypoints;
  final List<RouteModel> routes;
  final String status;

  const DirectionsResponse({
    // required this.geocodedWaypoints,
    required this.routes,
    required this.status,
  });

  factory DirectionsResponse.fromJson(Map<String, dynamic> json) {
    return DirectionsResponse(
      // geocodedWaypoints: (json['geocoded_waypoints'] as List)
      //     .map((e) => GeocodedWaypoint.fromJson(e))
      //     .toList(),
      routes:
          (json['routes'] as List).map((e) => RouteModel.fromJson(e)).toList(),
      status: json['status'] as String,
    );
  }

  @override
  List<Object?> get props => [routes, status];
}

class GeocodedWaypoint extends Equatable {
  final String geocoderStatus;
  final String placeId;
  final List<String> types;

  const GeocodedWaypoint({
    required this.geocoderStatus,
    required this.placeId,
    required this.types,
  });

  factory GeocodedWaypoint.fromJson(Map<String, dynamic> json) {
    return GeocodedWaypoint(
      geocoderStatus: json['geocoder_status'] as String,
      placeId: json['place_id'] as String,
      types: (json['types'] as List).cast<String>(),
    );
  }

  @override
  List<Object?> get props => [geocoderStatus, placeId, types];
}

class RouteModel extends Equatable {
  final Bounds bounds;
  final String copyrights;
  final List<Leg> legs;
  final OverviewPolyline overviewPolyline;
  final String summary;
  final List<dynamic> warnings;
  final List<int> waypointOrder;

  const RouteModel({
    required this.bounds,
    required this.copyrights,
    required this.legs,
    required this.overviewPolyline,
    required this.summary,
    required this.warnings,
    required this.waypointOrder,
  });

  factory RouteModel.fromJson(Map<String, dynamic> json) {
    return RouteModel(
      bounds: Bounds.fromJson(json['bounds'] as Map<String, dynamic>),
      copyrights: json['copyrights'] as String,
      legs: (json['legs'] as List).map((e) => Leg.fromJson(e)).toList(),
      overviewPolyline: OverviewPolyline.fromJson(
          json['overview_polyline'] as Map<String, dynamic>),
      summary: json['summary'] as String,
      warnings: json['warnings'] as List<dynamic>,
      waypointOrder: (json['waypoint_order'] as List).cast<int>(),
    );
  }

  @override
  List<Object?> get props => [
        bounds,
        copyrights,
        legs,
        overviewPolyline,
        summary,
        warnings,
        waypointOrder
      ];
}

class Bounds extends Equatable {
  final LatLng northeast;
  final LatLng southwest;

  const Bounds({required this.northeast, required this.southwest});

  factory Bounds.fromJson(Map<String, dynamic> json) {
    return Bounds(
      northeast: _latLngFromJson(json['northeast']),
      southwest: _latLngFromJson(json['southwest']),
    );
  }

  @override
  List<Object?> get props => [northeast, southwest];
}

class Leg extends Equatable {
  final Distance distance;
  final Duration duration;
  final String? endAddress;
  final LatLng endLocation;
  final String? startAddress;
  final LatLng startLocation;
  final List<Step> steps;

  const Leg({
    required this.distance,
    required this.duration,
    required this.endAddress,
    required this.endLocation,
    this.startAddress,
    required this.startLocation,
    required this.steps,
  });

  factory Leg.fromJson(Map<String, dynamic> json) {
    return Leg(
      distance: Distance.fromJson(json['distance'] as Map<String, dynamic>),
      duration: Duration.fromJson(json['duration'] as Map<String, dynamic>),
      endAddress: json['end_address'],
      endLocation: _latLngFromJson(json['end_location']),
      startAddress: json['start_address'],
      startLocation: _latLngFromJson(json['start_location']),
      steps: (json['steps'] as List).map((e) => Step.fromJson(e)).toList(),
    );
  }

  @override
  List<Object?> get props => [
        distance,
        duration,
        endAddress,
        endLocation,
        startAddress,
        startLocation,
        steps
      ];
}

class Step extends Equatable {
  final Distance distance;
  final Duration duration;
  final LatLng endLocation;
  final String htmlInstructions;
  final PolylineModel polyline;
  final LatLng startLocation;
  final String? maneuver;
  final String travelMode;

  const Step({
    required this.distance,
    required this.duration,
    required this.endLocation,
    required this.htmlInstructions,
    required this.polyline,
    required this.startLocation,
    this.maneuver,
    required this.travelMode,
  });

  factory Step.fromJson(Map<String, dynamic> json) {
    return Step(
      distance: Distance.fromJson(json['distance'] as Map<String, dynamic>),
      duration: Duration.fromJson(json['duration'] as Map<String, dynamic>),
      endLocation: _latLngFromJson(json['end_location']),
      htmlInstructions: json['html_instructions'] as String,
      polyline:
          PolylineModel.fromJson(json['polyline'] as Map<String, dynamic>),
      startLocation: _latLngFromJson(json['start_location']),
      maneuver: json['maneuver'] as String?,
      travelMode: json['travel_mode'] as String,
    );
  }

  @override
  List<Object?> get props => [
        distance,
        duration,
        endLocation,
        htmlInstructions,
        polyline,
        startLocation,
        maneuver,
        travelMode
      ];
}

class Distance extends Equatable {
  final String text;
  final int value;

  const Distance({required this.text, required this.value});

  factory Distance.fromJson(Map<String, dynamic> json) {
    return Distance(
      text: json['text'] as String,
      value: json['value'] as int,
    );
  }

  @override
  List<Object?> get props => [text, value];
}

class Duration extends Equatable {
  final String text;
  final int value;

  const Duration({required this.text, required this.value});

  factory Duration.fromJson(Map<String, dynamic> json) {
    return Duration(
      text: json['text'] as String,
      value: json['value'] as int,
    );
  }

  @override
  List<Object?> get props => [text, value];
}

class PolylineModel extends Equatable {
  final String points;

  const PolylineModel({required this.points});

  factory PolylineModel.fromJson(Map<String, dynamic> json) {
    return PolylineModel(points: json['points'] as String);
  }

  @override
  List<Object?> get props => [points];
}

class OverviewPolyline extends Equatable {
  final String points;

  const OverviewPolyline({required this.points});

  factory OverviewPolyline.fromJson(Map<String, dynamic> json) {
    return OverviewPolyline(points: json['points'] as String);
  }

  @override
  List<Object?> get props => [points];
}

// Helper funksiyası
LatLng _latLngFromJson(Map<String, dynamic> json) {
  return LatLng(
    (json['lat'] as num).toDouble(),
    (json['lng'] as num).toDouble(),
  );
}
