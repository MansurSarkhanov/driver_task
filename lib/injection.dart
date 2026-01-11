import 'package:driver_task/features/map/data/services/google_map_service.dart';
import 'package:driver_task/features/map/domain/google_map_domain.dart';
import 'package:driver_task/features/map/domain/repositories/google_map_repository.dart';
import 'package:driver_task/features/tasks/data/services/task_services.dart';
import 'package:driver_task/features/tasks/domain/repositories/task_repository.dart';
import 'package:driver_task/features/tasks/domain/task_domain.dart';
import 'package:get_it/get_it.dart';

import 'features/task_process/data/services/task_process_service.dart';
import 'features/task_process/domain/repositories/task_process_repository.dart';
import 'features/task_process/domain/task_process_domain.dart';

final getIt = GetIt.instance;
Future<void> init() async {
  getIt.registerLazySingleton<ITaskServices>(() => TaskServices());
  getIt.registerLazySingleton<TaskDomain>(
    () => TaskRepository(services: getIt<ITaskServices>()),
  );

  getIt.registerLazySingleton<IGoogleMapService>(() => GoogleMapService());
  getIt.registerLazySingleton<GoogleMapDomain>(
    () => GoogleMapRepository(service: getIt<IGoogleMapService>()),
  );

  getIt.registerLazySingleton<ITaskProcessService>(() => TaskProcessService());
  getIt.registerLazySingleton<TaskProcessDomain>(
    () => TaskProcessRepository(service: getIt<ITaskProcessService>()),
  );
}
