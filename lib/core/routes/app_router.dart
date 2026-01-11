import 'package:driver_task/core/routes/index.dart';

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
          create: (context) =>
              TaskListCubit(repository: getIt.get<TaskDomain>())
                ..fetchTaskList(),
          child: const TaskListScreen(),
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
              create: (context) =>
                  TaskDetailCubit(repository: getIt.get<TaskDomain>())
                    ..fetchTaskDetail(taskId),
            ),
            BlocProvider(
              create: (context) =>
                  GoogleMapCubit(repository: getIt.get<GoogleMapDomain>()),
            ),
            BlocProvider(create: (context) => MapLocationCubit()),
            BlocProvider(create: (context) => RouteCubit()),
            BlocProvider(
              create: (context) =>
                  TaskProcessCubit(repository: getIt.get<TaskProcessDomain>()),
            ),
          ],
          child: TaskDetailScreen(),
        );
      },
    ),
    GoRoute(
      path: Routes.scanPackages,
      builder: (context, state) {
        final taskDetail = state.extra as TaskDetailModel;
        return ScanPackagesPage(taskDetailModel: taskDetail);
      },
    ),
  ],
);
