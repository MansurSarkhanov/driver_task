import 'package:driver_task/core/constants/app_colors.dart';
import 'package:driver_task/features/map/presentation/bloc/google_map_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/extensions/gaps_extensions.dart';
import '../../../../core/helpers/google_map_helper.dart';
import '../../../../shared/components/custom_leading.dart';
import '../../../map/presentation/bloc/google_map_cubit.dart';
import '../../../map/presentation/bloc/map_location_cubit.dart';
import '../../../map/presentation/bloc/map_location_states.dart';
import '../../../map/presentation/bloc/route_cubit.dart';
import '../../../map/presentation/bloc/route_state.dart';
import '../widgets/task_detail_card.dart';

class TaskDetailScreen extends StatefulWidget {
  const TaskDetailScreen({super.key});
  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  GoogleMapController? mapController;

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  Future<void> _determinePosition() async {
    final currentPosition = await GoogleMapHelper.determinePosition();
    if (currentPosition != null) {
      if (mounted) {
        context.read<MapLocationCubit>().pickAddressOnMap(
          currentLocationLatLng: currentPosition,
        );
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    mapController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapLocationCubit, MapLocationState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.backgroundColor,
          body: state.currentLocation == null
              ? const Center(child: CircularProgressIndicator())
              : BlocListener<GoogleMapCubit, GoogleMapState>(
                  listener: (context, state) {
                    if (state is GoogleMapRouteCalculatedState) {
                      context.read<RouteCubit>().prepareAndSetRoute(
                        response: state.directions,
                      );
                    }
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Stack(
                          children: [
                            BlocConsumer<RouteCubit, RouteState>(
                              listener: (context, routeState) async {
                                if (routeState.polylinePoints.length >= 2) {
                                  final bounds = context
                                      .read<RouteCubit>()
                                      .buildBoundsFromPoints(
                                        routeState.polylinePoints,
                                      );
                                  if (mapController != null) {
                                    mapController!.animateCamera(
                                      CameraUpdate.newLatLngBounds(bounds, 50),
                                    );
                                  }
                                }
                              },
                              builder: (context, state) {
                                return GoogleMap(
                                  myLocationEnabled: true,
                                  myLocationButtonEnabled: false,
                                  mapType: MapType.normal,
                                  buildingsEnabled: true,
                                  polylines: state.polylines,
                                  markers: state.markers,
                                  initialCameraPosition: CameraPosition(
                                    target: context
                                        .watch<MapLocationCubit>()
                                        .state
                                        .currentLocation!,
                                    zoom: 15,
                                  ),
                                  onMapCreated:
                                      (GoogleMapController controller) =>
                                          mapController = controller,
                                  onCameraMoveStarted: () => context
                                      .read<GoogleMapCubit>()
                                      .setMapMoving(true),
                                  onCameraIdle: state.polylinePoints.isEmpty
                                      ? () {
                                          if (mapController != null) {
                                            context
                                                .read<MapLocationCubit>()
                                                .handleCameraIdle(
                                                  mapController!,
                                                  context,
                                                );
                                          }
                                        }
                                      : () => context
                                            .read<GoogleMapCubit>()
                                            .setMapMoving(false),
                                  zoomControlsEnabled: false,
                                  compassEnabled: false,
                                );
                              },
                            ),
                            TaskDetailCard(
                              onPressed: () {
                                if (mapController != null) {
                                  context
                                      .read<MapLocationCubit>()
                                      .centerToCurrentLocation(mapController!);
                                }
                              },
                            ),
                            Positioned(
                              left: context.dynamicWidth(0.05),
                              top: context.dynamicHeight(0.07),
                              child: CustomLeading(
                                bgColor: Colors.white,
                                widthHeight: 40,
                                icon: const Icon(
                                  Icons.arrow_back,
                                  color: Colors.black,
                                ),
                                onTab: () => context.pop(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}
