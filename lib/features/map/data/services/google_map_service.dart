import 'package:driver_task/core/config/request_executor.dart';
import 'package:driver_task/core/utils/enums/http_method_enum.dart';
import 'package:driver_task/shared/models/api_result.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/config/dio_client.dart';
import '../../../../env/app_env.dart';
import '../models/direction_response.dart';

abstract class IGoogleMapService {
  Future<ApiResult<DirectionsResponse>> getDirections({
    required LatLng origin,
    required LatLng destination,
  });
}

final class GoogleMapService extends RequestExecutor
    implements IGoogleMapService {
  GoogleMapService() : super(DioClient().dio);

  @override
  Future<ApiResult<DirectionsResponse>> getDirections({
    required LatLng origin,
    required LatLng destination,
  }) async {
    return executeRequest(
      url: 'https://maps.googleapis.com/maps/api/directions/json',
      parser: (json) => DirectionsResponse.fromJson(json),
      method: HttpMethodEnum.GET,
      query: {
        "origin": "${origin.latitude},${origin.longitude}",
        "destination": "${destination.latitude},${destination.longitude}",
        "key": AppEnv.googleApiKey,
        "units": 'metric',
        "mode": "driving",
      },
    );
  }
}
