import 'package:either_dart/either.dart';

import '../data/models/task_detail_response.dart';
import '../data/models/task_list_model.dart';

abstract class TaskDomain {
  Future<Either<List<TaskModel>, String>> getTaskList();
  Future<Either<TaskDetailModel, String>> getTaskDetail(String id);
  Future<Either<bool, String>> startTask(String id);
}
