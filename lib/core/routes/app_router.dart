import 'package:driver_task/features/splash/presentation/screens/splash_screen.dart';
import 'package:driver_task/features/tasks/data/services/task_services.dart';
import 'package:driver_task/features/tasks/domain/repositories/task_repository.dart';
import 'package:driver_task/features/tasks/presentation/bloc/cubit/task_list_cubit.dart';
import 'package:driver_task/features/tasks/presentation/screens/taks_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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
  ],
);
