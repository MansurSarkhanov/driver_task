import '../../../data/models/task_list_model.dart';

abstract class TaskListStates {}

final class TaskListInitial extends TaskListStates {}

final class TaskListLoading extends TaskListStates {}

final class TaskListSuccess extends TaskListStates {
  final List<TaskModel> tasks;
  TaskListSuccess({required this.tasks});
}

final class TaskListError extends TaskListStates {
  final String message;
  TaskListError({required this.message});
}
