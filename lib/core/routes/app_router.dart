import 'package:driver_task/features/splash/presentation/screens/splash_screen.dart';
import 'package:driver_task/features/tasks/data/services/task_services.dart';
import 'package:driver_task/features/tasks/domain/repositories/task_repository.dart';
import 'package:driver_task/features/tasks/presentation/bloc/cubit/task_list_cubit.dart';
import 'package:driver_task/features/tasks/presentation/screens/taks_list_screen.dart';
import 'package:driver_task/features/tasks/presentation/screens/task_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/map/data/services/google_map_service.dart';
import '../../features/map/domain/repositories/google_map_repository.dart';
import '../../features/map/presentation/bloc/google_map_cubit.dart';
import '../../features/map/presentation/bloc/map_location_cubit.dart';
import '../../features/map/presentation/bloc/route_cubit.dart';
import '../../features/tasks/presentation/bloc/cubit/task_detail_cubit.dart';
import 'routes.dart';

final _appRouterKey = GlobalKey<NavigatorState>();

final GoRouter appRouter = GoRouter(
  initialLocation: Routes.splash,
  navigatorKey: _appRouterKey,
  routes: [
    GoRoute(
      path: Routes.splash,
      builder: (context, state) {
        return const SplashScreen();
      },
    ),
    GoRoute(
      path: Routes.taskList,
      builder: (context, state) {
        return BlocProvider(
          create: (context) => TaskListCubit(
            repository: TaskRepository(services: TaskServices()),
          )..fetchTaskList(),
          child: const TaksListScreen(),
        );
      },
    ),
    GoRoute(
      path: Routes.taskDetail,
      builder: (context, state) {
        final taskId = state.pathParameters['id']!;
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => TaskDetailCubit(
                repository: TaskRepository(services: TaskServices()),
              )..fetchTaskDetail(taskId),
            ),
            BlocProvider(
              create: (context) => GoogleMapCubit(
                repository: GoogleMapRepository(service: GoogleMapService()),
              ),
            ),
            BlocProvider(create: (context) => MapLocationCubit()),
            BlocProvider(create: (context) => RouteCubit()),
          ],
          child: TaskDetailScreen(),
        );
      },
    ),
  ],
);
