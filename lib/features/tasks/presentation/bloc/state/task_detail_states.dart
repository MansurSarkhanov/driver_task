import 'package:driver_task/features/tasks/data/models/task_detail_response.dart';

abstract class TaskDetailStates {}

class TaskDetailInitial extends TaskDetailStates {}

class TaskDetailLoading extends TaskDetailStates {}

class TaskDetailSuccess extends TaskDetailStates {
  final TaskDetailModel taskDetail;

  TaskDetailSuccess({required this.taskDetail});
}

class TaskDetailError extends TaskDetailStates {
  final String message;

  TaskDetailError({required this.message});
}
