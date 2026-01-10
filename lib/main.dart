import 'package:driver_task/core/routes/app_router.dart';
import 'package:driver_task/features/map/data/services/google_map_service.dart';
import 'package:driver_task/features/tasks/data/services/task_services.dart';
import 'package:driver_task/features/tasks/domain/repositories/task_repository.dart';
import 'package:driver_task/features/tasks/presentation/bloc/cubit/task_detail_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/utils/localization_manager.dart';
import 'features/map/domain/repositories/google_map_repository.dart';
import 'features/map/presentation/bloc/google_map_cubit.dart';
import 'features/map/presentation/bloc/map_location_cubit.dart';
import 'features/map/presentation/bloc/route_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      supportedLocales: LocalizationManager.supportedLocales,
      path: LocalizationManager.path,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GoogleMapCubit(
            repository: GoogleMapRepository(service: GoogleMapService()),
          ),
        ),
        BlocProvider(create: (context) => MapLocationCubit()),
        BlocProvider(create: (context) => RouteCubit()),
        BlocProvider(
          create: (context) => TaskDetailCubit(
            repository: TaskRepository(services: TaskServices()),
          ),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return PopScope(
            canPop: false,
            child: MaterialApp.router(
              debugShowCheckedModeBanner: false,
              title: 'Driver Task',
              locale: context.locale,
              supportedLocales: context.supportedLocales,
              localizationsDelegates: [
                ...context.localizationDelegates,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              routerConfig: appRouter,
            ),
          );
        },
      ),
    );
  }
}
