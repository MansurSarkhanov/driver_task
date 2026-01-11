import 'package:either_dart/either.dart';

import '../../data/services/task_process_service.dart';
import '../task_process_domain.dart';

final class TaskProcessRepository extends TaskProcessDomain {
  final ITaskProcessService service;

  TaskProcessRepository({required this.service});
  @override
  Future<Either<bool, String>> failTask(String id) async {
    final response = await service.failTask(id);
    if (response.isSuccess) {
      return Left(true);
    }
    final message = response.toErrorResponse().error.name;
    return Right(message);
  }

  @override
  Future<Either<bool, String>> scanTasks(String id) async {
    final response = await service.scanTasks(id);
    if (response.isSuccess) {
      return Left(true);
    }
    final message = response.toErrorResponse().error.name;
    return Right(message);
  }

  @override
  Future<Either<bool, String>> startTask(String id) async {
    final response = await service.startTask(id);
    if (response.isSuccess) {
      return Left(true);
    }
    final message = response.toErrorResponse().error.name;
    return Right(message);
  }
}
