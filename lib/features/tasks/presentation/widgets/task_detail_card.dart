import 'package:driver_task/core/constants/icon_path.dart';
import 'package:driver_task/features/task_process/presentation/bloc/task_process_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../shared/components/custom_button.dart';
import '../../../map/presentation/bloc/google_map_cubit.dart';
import '../../../map/presentation/bloc/map_location_cubit.dart';
import '../bloc/cubit/task_detail_cubit.dart';
import '../bloc/state/task_detail_states.dart';
import 'task_info_detail.dart';

class TaskDetailCard extends StatelessWidget {
  const TaskDetailCard({super.key, required this.onPressed});

  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskDetailCubit, TaskDetailStates>(
      builder: (context, state) {
        return Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: AnimatedSlide(
            duration: const Duration(milliseconds: 500),
            offset: state is TaskDetailLoading
                ? const Offset(0, 1)
                : Offset.zero,
            curve: Curves.easeInOut,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: FloatingActionButton(
                    splashColor: Colors.white,
                    shape: const CircleBorder(),
                    backgroundColor: Colors.white,
                    onPressed: onPressed,
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Icon(
                        Icons.my_location_rounded,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                16.verticalSpace,
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 30,
                        spreadRadius: 10,
                        offset: const Offset(0, -4),
                      ),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(18.r),
                      topRight: Radius.circular(18.r),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 24,
                  ),
                  child: BlocBuilder<TaskDetailCubit, TaskDetailStates>(
                    builder: (context, state) {
                      if (state is TaskDetailLoading) {
                        return const Center(
                          child: CircularProgressIndicator(color: Colors.blue),
                        );
                      }
                      if (state is TaskDetailSuccess) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TaskInfoDetail(
                              title: state.taskDetail.title,
                              address: state.taskDetail.address,
                              distanceKm: state.taskDetail.distanceKm,
                              etaMin: state.taskDetail.etaMin,
                              packagesCount: state.taskDetail.bagsCount,
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: state.taskDetail.packages
                                  .map(
                                    (e) => Padding(
                                      padding: const EdgeInsets.only(top: 16.0),
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(IconPath.boxPath),
                                          8.horizontalSpace,
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(e.packageId),
                                              Text("${e.shipmentId} shipment"),
                                            ],
                                          ),
                                          Spacer(),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text("Barcode"),
                                              Text(e.barcode),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                            16.verticalSpace,
                            CustomButton(
                              text: 'start_task'.tr(),
                              onTap: () async {
                                final result = await context
                                    .read<TaskProcessCubit>()
                                    .startTask(
                                      id: state.taskDetail.taskId,
                                      context: context,
                                    );
                                if (result != null) {
                                  final destinationLocation =
                                      state.taskDetail.location;
                                  context
                                      .read<GoogleMapCubit>()
                                      .searchAndCalculateRoute(
                                        origin: context
                                            .read<MapLocationCubit>()
                                            .state
                                            .currentLocation,
                                        destination: LatLng(
                                          destinationLocation.lat,
                                          destinationLocation.lng,
                                        ),
                                      );
                                }
                              },
                            ),
                          ],
                        );
                      }
                      return SizedBox.shrink();
                    },
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
