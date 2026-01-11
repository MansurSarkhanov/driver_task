import 'package:driver_task/features/tasks/data/models/task_detail_response.dart';
import 'package:driver_task/features/tasks/data/models/task_list_model.dart';
import 'package:driver_task/features/tasks/domain/task_domain.dart';
import 'package:either_dart/either.dart';

import '../../data/services/task_services.dart';

final class TaskRepository implements TaskDomain {
  final ITaskServices services;

  TaskRepository({required this.services});
  @override
  Future<Either<List<TaskModel>, String>> getTaskList() async {
    final response = await services.getTaskList();
    if (response.isSuccess) {
      return Left(response.data!.data.tasks);
    }
    return Right(response.error!.message);
  }

  @override
  Future<Either<TaskDetailModel, String>> getTaskDetail(String id) async {
    final response = await services.getTaskDetail(id);
    if (response.isSuccess) {
      return Left(response.data!.data);
    }
    return Right(response.error!.message);
  }
}
